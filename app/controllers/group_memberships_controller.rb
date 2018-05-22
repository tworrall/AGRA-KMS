class GroupMembershipsController < ApplicationController
  before_action :set_group_membership, only: [:edit, :update, :destroy, :leave]
  before_action :authenticate_user!
  before_action :authorize_admin

      # GET /groups
      def index
        @gms = GroupMembership.find_by_sql("select gm.id, g.name, g.description, u.email from group_memberships gm, groups g, users u where gm.member_id = u.id and gm.group_id = g.id order by g.name;")
      end

      # GET /groups/new
      def new
        @groups = Group.all
        @group_membership = GroupMembership.new
      end

      # GET /groups/1/edit
      def edit
      end

      # POST /groups
      def create
        
        member_id_list = params[:member_id].split(",")
        if member_id_list.size < 1
          @group_membership = GroupMembership.new(member_type: params[:member_type], group_id: params[:group_id], group_name: params[:group_name], created_at: params[:created_at])
        else
          member_id_list.each do | mbr |
            @group_membership = GroupMembership.create(member_id: mbr, member_type: params[:member_type], group_id: params[:group_id], group_name: params[:group_name], created_at: params[:created_at])
          end
        end

        if @group_membership.save
          if member_id_list.size > 1
            flash.keep[:notice] = 'The group memberships were successfully created.'
          else
            flash.keep[:notice] = 'The group membership was successfully created.'
          end
          redirect_to action: 'index'
        else
          @groups = Group.all
          render :new
        end
      end

      # PATCH/PUT /groups/1
      def update
        if @group_membership.update(name: params[:group][:name], internal_name: params[:group][:internal_name])
          flash.keep[:notice] = 'The "' + params[:group][:name] + '" group was successfully updated.'
          redirect_to action: 'index'
        else
          render :edit
        end
      end

      # DELETE /groups/1
      def destroy
        @group_membership.destroy
        redirect_to group_memberships_url, notice: 'The Group Membership was successfully deleted.'
      end

      def get_users_for_group
        search_string = "select u.id, u.email from users u where u.id NOT IN (select gm.member_id from users u left outer join group_memberships gm on u.id = gm.member_id where gm.group_id = ?)"
        search_value = []
        search_value << params[:groupid]
        search_query = [search_string] + search_value
        @users = User.find_by_sql(search_query)
        option_string = "<option value=\"\" selected></option>"
        @users.each do |user|
          option_string += "<option value=\"#{user.id}\">#{user.email}</option>"
        end
        respond_to do |format|
          format.html { render html: option_string.html_safe }
        end
        
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_group_membership
          @group_membership = GroupMembership.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def group_params
          #params.require(:group).permit(:name)
        end
        
  end

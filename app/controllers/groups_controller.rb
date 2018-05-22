class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy, :leave]
  before_action :authenticate_user!
  before_action :authorize_admin


      # GET /groups
      def index
        @groups = Group.order(:name)
      end

      # GET /groups/1
#      def show
#      end

      # GET /groups/new
      def new
        @group = Group.new
      end

      # GET /groups/1/edit
      def edit
      end

      # POST /groups
      def create
         @group = Group.new(name: params[:group][:name], description: params[:group][:description])

        if @group.save
          @group_membership = GroupMembership.new(member_id: current_user.id, member_type: "User", group_id: @group.id, group_name: params[:group][:name], created_at: DateTime.now)
          @group_membership.save
          flash.keep[:notice] = 'The "' + params[:group][:name] + '" group was successfully created.'
          redirect_to action: 'index'
        else
          render :new
        end
      end

      # PATCH/PUT /groups/1
      def update
        if @group.update(name: params[:group][:name], description: params[:group][:description])
          GroupMembership.where(group_id: @group.id).update_all(group_name:  params[:group][:name])
          flash.keep[:notice] = 'The "' + params[:group][:name] + '" group was successfully updated.'
          redirect_to action: 'index'
        else
          render :edit
        end
      end

      # DELETE /groups/1
      def destroy
        group_id = @group.id
        @group.destroy
        GroupMembership.where(group_id: group_id).destroy_all
        redirect_to groups_url, notice: 'The group was successfully deleted.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_group
          @group = Group.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def group_params
          #params.require(:group).permit(:name)
        end
  end

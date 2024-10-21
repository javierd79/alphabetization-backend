class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end

  # GET /users/{email}
  def show
    render json: { user: @user }, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.role = 'Student'
    if @user.save
      render json: { message: "User created successfully", user: @user }, status: :created
    else
      render json: { message: "Oops! Something has happened", user: @user, errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{email}
  def update
    unless @user.update(user_params)
      render json: { message: "Oops! Something has happened", user: @user, errors: @user.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: { message: "User updated", user: @user }, status: :ok
    end
  end

  # DELETE /users/{email}
  def destroy
    if @user.destroy
      render json: { message: "Users deleted succesfully", user: @user }, status: :ok
    else
      render json: { message: "Oops! Something has happened" }. status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by_email!(params[:_email])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :phone, :email, :profession, :password, :password_confirmation
    )
  end
end
class SubjectsController < ApplicationController
  before_action :authorize_request, except: [:available, :reports]
  
  def available
    @subjects_available = Subject.includes(:company).available
    render json: @subjects_available, status: :ok
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      render json: { message: "User created successfully", subject: @subject }, status: :created
    else
      render json: { message: "Oops! Something has happened", subject: @subject, errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def add_user
    @subject = Subject.find(params[:id])
    if @subject
      students_subscribed = @subject.students_subscribed
      students_subscribed << @current_user.id
      if @subject.update(students_subscribed: students_subscribed)
        render json: { message: "Subject updated", subject: @subject }, status: :ok
      else
        render json: { message: "Something has happened" }, status: :unprocessable_entity
      end
    else
      render json: { message: "Subject not found" }, status: :not_found
    end
  end

  def reports
    @subject = Subject.find(params[:id])
    if @subject
      render json: @subject.reports, status: :ok
    else
      render json: { message: "Subject not found" }, status: :not_found
    end
  end

  private

  def subjects_param
    params.permit(
      :name, :beginning, :ending, :max_students, :students_subscribed, :company_id
    )
  end
end
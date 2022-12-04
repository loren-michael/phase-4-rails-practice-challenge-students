class StudentsController < ApplicationController

  def show
    find_student
    render json: student, include: :instructors
  end

  def create
    student = Student.create(student_params)
    if student.valid?
      render json: student, status: :created
    else
      render json: { student.errors.full_messages }, status: :unprocessible_entity
    end
    
  end

  def update
    find_student
    if student
      student.update(student_params)
      render json: student, status: :updated      
    else
      render json: { error: "This student could not be found." }
    end
  end

  def destroy
    find_student
    if student
      student.destroy
      render json: { message: "This student has been deleted." }
    else
      render json: { error: "This student could not be found." }
    end
  end

  private

  def find_student
    student = Student.find(params[:id])
  end

  def student_params
    params.permit( :name, :age, :major )
  end

end

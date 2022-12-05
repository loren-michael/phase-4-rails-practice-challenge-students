class StudentsController < ApplicationController

  def index 
    students = Student.all
    render json: students, only: [:name, :age, :major], include: :instructor
  end

  def show
    student = find_student
    if student
      render json: student, include: :instructor
    else
      render json: { error: "This student could not be found." }
    end
  end

  def create
    student = Student.create(student_params)
    if student.valid?
      render json: student, status: :created
    else
      render json: { errors: student.error.full_messages }, status: :unprocessible_entity
    end
    
  end

  def update
    student = find_student
    if student
      student.update(student_params)
      render json: student, status: :accepted      
    else
      render json: { error: "This student could not be found." }
    end
  end

  def destroy
    student = find_student
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

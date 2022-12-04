class InstructorsController < ApplicationController

  def index
    instructors = Instructor.all
    render json: instructors, include: :students
  end

  def create
    instructor = Instructor.create(params(instructor_params))
    render json: instructor, status: :created
  end

  def update
    find_instructor
    if instructor
      instructor.update(instructor_params)
      render json: instructor
    else
      render json: { error: "Instructor not found." }
    end
  end

  def show
    find_instructor
    render json: instructor, include: [ :students ]
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    render json: { message: "Record was destroyed." }
  end

  private

  def find_instructor
    instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:name)
  end

end

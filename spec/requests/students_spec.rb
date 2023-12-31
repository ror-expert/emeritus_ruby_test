require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/students", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Batch. As you add validations to Batch, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { first_name: 'student-1', last_name: 'kk', email: 'student-1@example.com' } }

  let(:invalid_attributes) { { first_name: nil, last_name: nil, email: nil } }

  let(:school) { create(:school) }
  let(:school_admin)   { create(:user, :school_admin) }

  let(:school2) { create(:school) }
  let(:school_admin2)   { create(:user, :school_admin) }

  let(:admin)  { create(:user, :admin) }
  let(:student) { create(:user) }

  let!(:school_user) { create(:school_user, user: school_admin, school: school) }
  let!(:student_school_user) { create(:school_user, user: student, school: school) }

  let!(:school_user2) { create(:school_user, user: school_admin2, school: school2) }

  let(:course) { create(:course, school: school) }
  let(:course2) { create(:course, school: school2) }

  let(:batch) { create(:batch, course: course) }
  let(:batch2) { create(:batch, course: course2) }

  let(:batch_user) { create(:batch_user, batch: batch, student: student)}

  describe "GET /index" do
    context "As a Admin" do
      it "renders a successful response" do
        sign_in admin
        get course_batch_students_url(course, batch)
        expect(response).to be_successful
      end

      it "can access other school batches" do
        sign_in admin
        get course_batch_students_url(course2, batch2)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "renders a successful response" do
        sign_in school_admin
        get course_batch_students_url(course, batch)
        expect(response).to be_successful
      end

      it "can not access other school related batches" do
        sign_in school_admin
        expect {
        get course_batch_students_url(course2, batch2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "As a Student" do
      it "can not access index page" do
        sign_in student
        get course_batch_students_url(course, batch)
        expect(response).not_to be_successful
      end
    end
  end

  describe "GET /new" do
    context "As a Admin" do
      it "can access student new page" do
        sign_in admin
        get new_course_batch_student_url(course, batch)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "can access student new page" do
        sign_in school_admin
        get new_course_batch_student_url(course, batch)
        expect(response).to be_successful
      end
    end

    context "As a Student" do
      it "can not access student new page" do
        sign_in student
        get new_course_batch_student_url(course, batch)
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST /create" do
    context "As a Admin" do
      context "with valid parameters" do
        it "creates a new Student" do
          sign_in admin
          expect {
            post course_batch_students_url(course, batch), params: { student: valid_attributes }
          }.to change(User, :count).by(1)
        end

        it "redirects to the student list page" do
          sign_in admin
          post course_batch_students_url(course, batch), params: { student: valid_attributes }
          expect(response).to redirect_to(course_batch_students_url(course, batch))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Student" do
          sign_in admin
          expect {
            post course_batch_students_url(course, batch), params: { student: invalid_attributes }
          }.to change(User, :count).by(0)
        end

        it "does not render a successful response (i.e. to display the 'new' template)" do
          sign_in admin
          post course_batch_students_url(course, batch), params: { student: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a School Admin" do
      context "with valid parameters" do
        it "creates a new Student" do
          sign_in school_admin
          expect {
            post course_batch_students_url(course, batch), params: { student: valid_attributes }
          }.to change(User, :count).by(1)
        end

        it "redirects to the student list page" do
          sign_in school_admin
          post course_batch_students_url(course, batch), params: { student: valid_attributes }
          expect(response).to redirect_to(course_batch_students_url(course, batch))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Student" do
          sign_in admin
          expect {
            post course_batch_students_url(course, batch), params: { student: invalid_attributes }
          }.to change(User, :count).by(0)
        end

        it "does not render a successful response (i.e. to display the 'new' template)" do
          sign_in admin
          post course_batch_students_url(course, batch), params: { student: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a Student" do
      context "with valid parameters" do
        it "can not create a new Batch" do
          sign_in student
          post course_batch_students_url(course, batch), params: { student: valid_attributes }
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe "POST /enrollment" do
    context "As a Admin" do
      it "can not request for enrollment" do
        sign_in admin
        expect {
            post course_batch_student_enrollment_url(course, batch, student)
          }.to change(BatchUser, :count).by(0)
        expect(response).not_to be_successful
      end
    end

    context "As a School Admin" do
      it "can not request for enrollment" do
        sign_in school_admin
        expect {
            post course_batch_student_enrollment_url(course, batch, student)
          }.to change(BatchUser, :count).by(0)
        expect(response).not_to be_successful
      end
    end

    context "As a Student" do
      it "can request for enrollment" do
        sign_in student
        expect {
            post course_batch_student_enrollment_url(course, batch, student)
          }.to change(BatchUser, :count).by(1)
        expect(response).to redirect_to(course_batches_url(course))
      end
    end
  end

  describe "PUT /accept" do
    before do
      course
      batch
      student
      student_school_user
      batch_user
    end

    context "As a Admin" do
      it "can access accept action" do
        sign_in admin
        put course_batch_student_accept_url(course, batch, student)
        expect(batch_user.aasm_state).to eq('pending')

        expect(batch_user.reload.aasm_state).to eq('accepted')
        expect(response).to redirect_to(course_batch_students_url(course, batch))
      end
    end

    context "As a School Admin" do
      it "can access accept action" do
        sign_in school_admin
        put course_batch_student_accept_url(course, batch, student)
        expect(batch_user.aasm_state).to eq('pending')

        expect(batch_user.reload.aasm_state).to eq('accepted')
        expect(response).to redirect_to(course_batch_students_url(course, batch))
      end
    end

    context "As a Student" do
      it "can not access accept action" do
        sign_in student
        put course_batch_student_accept_url(course, batch, student)
        expect(response).not_to be_successful
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PUT /reject" do
    before do
      course
      batch
      student
      student_school_user
      batch_user
    end

    context "As a Admin" do
      it "can access reject action" do
        sign_in admin
        put course_batch_student_reject_url(course, batch, student)
        expect(batch_user.aasm_state).to eq('pending')

        expect(batch_user.reload.aasm_state).to eq('rejected')
        expect(response).to redirect_to(course_batch_students_url(course, batch))
      end
    end

    context "As a School Admin" do
      it "can access reject action" do
        sign_in school_admin
        put course_batch_student_reject_url(course, batch, student)
        expect(batch_user.aasm_state).to eq('pending')

        expect(batch_user.reload.aasm_state).to eq('rejected')
        expect(response).to redirect_to(course_batch_students_url(course, batch))
      end
    end

    context "As a Student" do
      it "can not access reject action" do
        sign_in student
        put course_batch_student_reject_url(course, batch, student)
        expect(response).not_to be_successful
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

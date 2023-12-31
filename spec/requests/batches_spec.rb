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

RSpec.describe "/batches", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Batch. As you add validations to Batch, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { name: 'batch-001' } }

  let(:invalid_attributes) { { name: '' } }

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

  describe "GET /index" do
    context "As a Admin" do
      it "renders a successful response" do
        sign_in admin
        get course_batches_url(course)
        expect(response).to be_successful
      end

      it "can access other school batches" do
        sign_in admin
        get course_batches_url(course2)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "renders a successful response" do
        sign_in school_admin
        get course_batches_url(course)
        expect(response).to be_successful
      end

      it "can not access other school related batches" do
        sign_in school_admin
        expect {
        get course_batches_url(course2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end

    end

    context "As a Student" do
      it "renders a successful response" do
        sign_in student
        get course_batches_url(course)
        expect(response).to be_successful
      end
      
      it "can not access other school related batches" do
        sign_in student
        expect {
        get course_batches_url(course2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end

    end
  end

  describe "GET /show" do
    context "As a Admin" do
      it "renders a successful response" do
        sign_in admin
        get course_batch_url(course, batch)
        expect(response).to be_successful
      end

      it "can access other school batches" do
        sign_in admin
        get course_batch_url(course2, batch2)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "renders a successful response" do
        sign_in school_admin
        get course_batch_url(course, batch)
        expect(response).to be_successful
      end

      it "can not access other school batches" do
        sign_in school_admin
        expect{ get course_batch_url(course2, batch2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "As a Student" do
      it "renders a successful response" do
        sign_in student
        get course_batch_url(course, batch)
        expect(response).to be_successful
      end

      it "can not access other school batches" do
        sign_in student
        expect{ get course_batch_url(course2, batch2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET /new" do
    context "As a Admin" do
      it "can access batch new page" do
        sign_in admin
        get new_course_batch_url(course)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "can access batch new page" do
        sign_in school_admin
        get new_course_batch_url(course)
        expect(response).to be_successful
      end
    end

    context "As a Student" do
      it "can not access batch new page" do
        sign_in student
        get new_course_batch_url(course)
        expect(response).not_to be_successful
      end
    end
  end

  describe "GET /edit" do
    context "As a Admin" do
      it "renders a successful response" do
        sign_in admin
        get edit_course_batch_url(course, batch)
        expect(response).to be_successful
      end
    end

    context "As a School Admin" do
      it "renders a successful response" do
        sign_in school_admin
        get edit_course_batch_url(course, batch)
        expect(response).to be_successful
      end
    end

    context "As a Student" do
      it "can not access batch edit page" do
        sign_in student
        get edit_course_batch_url(course, batch)
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST /create" do
    context "As a Admin" do
      context "with valid parameters" do
        it "creates a new Batch" do
          sign_in admin
          expect {
            post course_batches_url(course), params: { batch: valid_attributes }
          }.to change(Batch, :count).by(1)
        end

        it "redirects to the batch list page" do
          sign_in admin
          post course_batches_url(course), params: { batch: valid_attributes }
          expect(response).to redirect_to(course_batches_url(course))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Batch" do
          sign_in admin
          expect {
            post course_batches_url(course), params: { batch: invalid_attributes }
          }.to change(Batch, :count).by(0)
        end

        it "does not render a successful response (i.e. to display the 'new' template)" do
          sign_in admin
          post course_batches_url(course), params: { batch: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a School Admin" do
      context "with valid parameters" do
        it "creates a new Batch" do
          sign_in school_admin
          expect {
            post course_batches_url(course), params: { batch: valid_attributes }
          }.to change(Batch, :count).by(1)
        end

        it "redirects to the batch list page" do
          sign_in school_admin
          post course_batches_url(course), params: { batch: valid_attributes }
          expect(response).to redirect_to(course_batches_url(course))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Batch" do
          sign_in school_admin
          expect {
            post course_batches_url(course), params: { batch: invalid_attributes }
          }.to change(Batch, :count).by(0)
        end

        it "does not render a successful response (i.e. to display the 'new' template)" do
          sign_in school_admin
          post course_batches_url(course), params: { batch: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a Student" do
      context "with valid parameters" do
        it "can not create a new Batch" do
          sign_in student
          post course_batches_url(course), params: { batch: valid_attributes }
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe "PATCH /update" do
    context "As a Admin" do
      context "with valid parameters" do
        let(:new_attributes) { { name: 'test-batch-200000' } }

        it "updates the requested batch" do
          sign_in admin
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          batch.reload
          expect(batch.name).to eq('test-batch-200000')
        end

        it "redirects to the batch" do
          sign_in admin
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          batch.reload
          expect(response).to redirect_to(course_batch_url(course, batch))
        end
      end

      context "with invalid parameters" do
        it "does not renders a successful response (i.e. to display the 'edit' template)" do
          sign_in school_admin
          patch course_batch_url(course, batch), params: { batch: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a School Admin" do
      context "with valid parameters" do
        let(:new_attributes) { { name: 'test-batch-200000' } }

        it "updates the requested batch" do
          sign_in school_admin
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          batch.reload
          expect(batch.name).to eq('test-batch-200000')
        end

        it "redirects to the batch" do
          sign_in school_admin
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          batch.reload
          expect(response).to redirect_to(course_batch_url(course, batch))
        end
      end

      context "with invalid parameters" do
        it "does not renders a successful response (i.e. to display the 'edit' template)" do
          sign_in school_admin
          patch course_batch_url(course, batch), params: { batch: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    context "As a Student" do
      context "with valid parameters" do
        let(:new_attributes) { { name: 'test-batch-200000' } }

        it "can not update the requested batch" do
          sign_in student
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          expect(batch.name).not_to eq('test-batch-200000')
          expect(response).not_to be_successful
        end

        it "redirects to the home page" do
          sign_in student
          patch course_batch_url(course, batch), params: { batch: new_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "DELETE /destroy" do
    context "As a Admin" do
      it "destroys the requested batch" do
        sign_in admin
        batch = course.batches.create!(valid_attributes)
        expect {
          delete course_batch_url(course, batch)
        }.to change(Batch, :count).by(-1)
      end

      it "redirects to the batches list" do
        sign_in admin
        batch = course.batches.create!(valid_attributes)
        delete course_batch_url(course, batch)
        expect(response).to redirect_to(course_batches_url(course))
      end
    end

    context "As a School Admin" do
      it "destroys the requested batch" do
        sign_in school_admin
        batch = course.batches.create!(valid_attributes)
        expect {
          delete course_batch_url(course, batch)
        }.to change(Batch, :count).by(-1)
      end

      it "redirects to the batches list" do
        sign_in school_admin
        batch = course.batches.create!(valid_attributes)
        delete course_batch_url(course, batch)
        expect(response).to redirect_to(course_batches_url(course))
      end
    end

    context "As a Student" do
      it "can not destroy the requested batch" do
        sign_in student
        batch = course.batches.create!(valid_attributes)
        expect {
          delete course_batch_url(course, batch)
        }.to change(Batch, :count).by(0)

        expect(response).not_to be_successful
      end
    end
  end
end

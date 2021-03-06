require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PostCategoriesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # PostCategory. As you add validations to PostCategory, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostCategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all post_categories as @post_categories" do
      post_category = PostCategory.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:post_categories)).to eq([post_category])
    end
  end

  describe "GET #show" do
    it "assigns the requested post_category as @post_category" do
      post_category = PostCategory.create! valid_attributes
      get :show, {:id => post_category.to_param}, valid_session
      expect(assigns(:post_category)).to eq(post_category)
    end
  end

  describe "GET #new" do
    it "assigns a new post_category as @post_category" do
      get :new, {}, valid_session
      expect(assigns(:post_category)).to be_a_new(PostCategory)
    end
  end

  describe "GET #edit" do
    it "assigns the requested post_category as @post_category" do
      post_category = PostCategory.create! valid_attributes
      get :edit, {:id => post_category.to_param}, valid_session
      expect(assigns(:post_category)).to eq(post_category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PostCategory" do
        expect {
          post :create, {:post_category => valid_attributes}, valid_session
        }.to change(PostCategory, :count).by(1)
      end

      it "assigns a newly created post_category as @post_category" do
        post :create, {:post_category => valid_attributes}, valid_session
        expect(assigns(:post_category)).to be_a(PostCategory)
        expect(assigns(:post_category)).to be_persisted
      end

      it "redirects to the created post_category" do
        post :create, {:post_category => valid_attributes}, valid_session
        expect(response).to redirect_to(PostCategory.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post_category as @post_category" do
        post :create, {:post_category => invalid_attributes}, valid_session
        expect(assigns(:post_category)).to be_a_new(PostCategory)
      end

      it "re-renders the 'new' template" do
        post :create, {:post_category => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested post_category" do
        post_category = PostCategory.create! valid_attributes
        put :update, {:id => post_category.to_param, :post_category => new_attributes}, valid_session
        post_category.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested post_category as @post_category" do
        post_category = PostCategory.create! valid_attributes
        put :update, {:id => post_category.to_param, :post_category => valid_attributes}, valid_session
        expect(assigns(:post_category)).to eq(post_category)
      end

      it "redirects to the post_category" do
        post_category = PostCategory.create! valid_attributes
        put :update, {:id => post_category.to_param, :post_category => valid_attributes}, valid_session
        expect(response).to redirect_to(post_category)
      end
    end

    context "with invalid params" do
      it "assigns the post_category as @post_category" do
        post_category = PostCategory.create! valid_attributes
        put :update, {:id => post_category.to_param, :post_category => invalid_attributes}, valid_session
        expect(assigns(:post_category)).to eq(post_category)
      end

      it "re-renders the 'edit' template" do
        post_category = PostCategory.create! valid_attributes
        put :update, {:id => post_category.to_param, :post_category => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post_category" do
      post_category = PostCategory.create! valid_attributes
      expect {
        delete :destroy, {:id => post_category.to_param}, valid_session
      }.to change(PostCategory, :count).by(-1)
    end

    it "redirects to the post_categories list" do
      post_category = PostCategory.create! valid_attributes
      delete :destroy, {:id => post_category.to_param}, valid_session
      expect(response).to redirect_to(post_categories_url)
    end
  end

end

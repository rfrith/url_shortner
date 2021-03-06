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

RSpec.describe ShortUrlsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # ShortUrl. As you add validations to ShortUrl, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {long: "http://www.another.long.url/to/shorten/"}
  }

  let(:invalid_attributes) {
    {long: "www.another.long.url/to/shorten/"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ShortUrlsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all short_urls as @short_urls" do
      short_url = ShortUrl.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:short_urls)).to eq([short_url])
    end
  end

  describe "GET #show" do
    it "assigns the requested short_url as @short_url" do
      short_url = ShortUrl.create! valid_attributes
      get :show, {:id => short_url.to_param}, valid_session
      expect(assigns(:short_url)).to eq(short_url)
    end
  end

  describe "GET #new" do
    it "assigns a new short_url as @short_url" do
      get :new, {}, valid_session
      expect(assigns(:short_url)).to be_a_new(ShortUrl)
    end
  end

  describe "GET #edit" do
    it "assigns the requested short_url as @short_url" do
      short_url = ShortUrl.create! valid_attributes
      get :edit, {:id => short_url.to_param}, valid_session
      expect(assigns(:short_url)).to eq(short_url)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ShortUrl" do
        expect {
          post :create, {:short_url => valid_attributes}, valid_session
        }.to change(ShortUrl, :count).by(1)
      end

      it "assigns a newly created short_url as @short_url" do
        post :create, {:short_url => valid_attributes}, valid_session
        expect(assigns(:short_url)).to be_a(ShortUrl)
        expect(assigns(:short_url)).to be_persisted
      end

      it "redirects to the created short_url" do
        post :create, {:short_url => valid_attributes}, valid_session
        expect(response).to redirect_to(ShortUrl.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved short_url as @short_url" do
        post :create, {:short_url => invalid_attributes}, valid_session
        expect(assigns(:short_url)).to be_a_new(ShortUrl)
      end

      it "re-renders the 'new' template" do
        post :create, {:short_url => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {long: "http://www.another.long.url/to/shorten/edited/"}
      }

      it "updates the requested short_url" do
        short_url = ShortUrl.create! valid_attributes
        put :update, {:id => short_url.to_param, :short_url => new_attributes}, valid_session
        short_url.reload
        expect(short_url.long).to eql("http://www.another.long.url/to/shorten/edited/")
      end

      it "assigns the requested short_url as @short_url" do
        short_url = ShortUrl.create! valid_attributes
        put :update, {:id => short_url.to_param, :short_url => valid_attributes}, valid_session
        expect(assigns(:short_url)).to eq(short_url)
      end

      it "redirects to the short_url" do
        short_url = ShortUrl.create! valid_attributes
        put :update, {:id => short_url.to_param, :short_url => valid_attributes}, valid_session
        expect(response).to redirect_to(short_url)
      end
    end

    context "with invalid params" do
      it "assigns the short_url as @short_url" do
        short_url = ShortUrl.create! valid_attributes
        put :update, {:id => short_url.to_param, :short_url => invalid_attributes}, valid_session
        expect(assigns(:short_url)).to eq(short_url)
      end

      it "re-renders the 'edit' template" do
        short_url = ShortUrl.create! valid_attributes
        put :update, {:id => short_url.to_param, :short_url => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested short_url" do
      short_url = ShortUrl.create! valid_attributes
      expect {
        delete :destroy, {:id => short_url.to_param}, valid_session
      }.to change(ShortUrl, :count).by(-1)
    end

    it "redirects to the short_urls list" do
      short_url = ShortUrl.create! valid_attributes
      delete :destroy, {:id => short_url.to_param}, valid_session
      expect(response).to redirect_to(short_urls_url)
    end
  end

  describe "GET #redirect" do
    it "uses provided short url and redirects to its corresponding mapped long url" do
      short_url = ShortUrl.create! valid_attributes
      get :redirect, {:id => short_url.short.chars.last(5).join}, valid_session
      expect(response).to redirect_to(short_url.long)
    end
  end

end

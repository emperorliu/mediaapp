require 'spec_helper'

describe MediaItemsController do
  let(:jeff) { Fabricate(:user) }
  
  describe "GET index" do
    context "with authenticated users" do
      before { set_current_user(jeff) }
      
      it "should show the index template" do
        get :index
        expect(response).to render_template :index
      end

      it "should set the @media_items variable to equal all media items of the current_user" do
        media_item1 = Fabricate(:media_item, user: jeff)
        media_item2 = Fabricate(:media_item, user: jeff)
        get :index
        expect(assigns(:media_items)).to eq([media_item2, media_item1])
      end
    end

  it_behaves_like "requires sign in" do
    let(:action) { get :index }
  end

end

  describe "GET new" do
    context "with authenticated users" do
      before { set_current_user(jeff) }

      it "should render the new media_item page" do
        get :new
        expect(response).to render_template 'media_items/new'
      end

      it "sets the @media_item variable" do
        get :new
        expect(assigns[:media_item]).to be_instance_of(MediaItem)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
end

  describe "POST create" do
    context "with authenticated users" do
      before { set_current_user(jeff) }

      context "with valid inputs" do
        before { post :create, media_item: Fabricate.attributes_for(:media_item) }
        
        it "creates a media item" do
          expect(MediaItem.count).to eq(1)
        end

        it "creates a media item associated with the user" do
          expect(MediaItem.first.user).to eq(jeff)
        end

        it "redirects to media items page" do
          expect(response).to redirect_to root_path
        end

      end

    context "with invalid inputs" do
      before { post :create, media_item: { title: "hey", medium: "there" } }
      
      it "does not create a media item" do
        expect(MediaItem.count).to eq(0)
      end

      it "renders the add media item page" do
        expect(response).to render_template 'media_items/new'
      end

      it "sets the @media_item" do
        expect(assigns[:media_item]).to be_instance_of(MediaItem)
      end
    end

    end

    it_behaves_like "requires sign in" do
     let(:action) { post :create, media_item: { title: "hey", medium: "there" } }
    end

  end

  describe "DELETE destroy" do
    
    context "with authenticated users" do
      it "destroys the item of the current user" do
        set_current_user(jeff)
        media_item1 = Fabricate(:media_item, user: jeff)
        delete :destroy, id: media_item1.id
        expect(MediaItem.count).to eq(0)
      end

      it "redirects to the items page" do
        set_current_user(jeff)
        media_item1 = Fabricate(:media_item, user: jeff)
        delete :destroy, id: media_item1.id
        expect(response).to redirect_to media_items_path
      end

      it "doesn't delete the item if it's not of the current user" do
        suzy = Fabricate(:user)
        set_current_user(jeff)
        media_item1 = Fabricate(:media_item, user: suzy)
        delete :destroy, id: media_item1.id
        expect(MediaItem.count).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirects to the root path" do
        session[:user_id] = nil
        media_item1 = Fabricate(:media_item, user: jeff)
        delete :destroy, id: media_item1.id
        expect(response).to redirect_to root_path
      end
    end


  end


end
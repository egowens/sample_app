require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

    describe "error messages" do
      before { click_button "Post" }
      it { should have_content("error") }
    end
  end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create micropost" do
        expect{ click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost status" do
    before do
      FactoryGirl.create(:micropost, user: user)
      visit root_path
    end

    it "should have the right micropost number" do
      expect(page).to have_content(Micropost.count)
    end
    it "should pluralize microposts correctly" do
      if Micropost.count ==1
        expect(page).to have_content("micropost")
      elsif Micropost.count > 1
        expect(page).to have_content("microposts")
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as corrent user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
end

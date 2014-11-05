require 'spec_helper'

describe Flickr::PhotoList do
  let(:current_page)  { 3 }
  let(:total_pages)   { 100 }

  subject { Flickr::PhotoList.from(photo_hash) }

  describe ".from" do

    it "should build the photo list from the hash" do
      subject.page.should be current_page
      subject.pages.should be total_pages

      subject.photos.zip(photo_list).each do |(photo, photo_hash)|
        photo.id.should        eq photo_hash["id"]
        photo.farm_id.should   eq photo_hash["farm"]
        photo.server_id.should eq photo_hash["server"]
        photo.secret.should    eq photo_hash["secret"]
        photo.title.should     eq photo_hash["title"]
      end
    end

    context "when there are no photos" do
      subject { Flickr::PhotoList.from(empty_photo_hash) }

      it "should be true" do
        subject.page.should eq 0
        subject.pages.should eq 0
        subject.photos.empty?.should be_truthy
      end
    end
  end

  describe "#empty?" do
    context "when there are no photos" do
      subject { Flickr::PhotoList.from(empty_photo_hash) }

      it "should be true" do
        subject.empty?.should be_truthy
      end
    end

    context "when there are some photos" do
      it "should be false" do
        subject.empty?.should be_falsy
      end
    end
  end

  describe "#current_page" do
    let(:current_page)  { 24 }
    let(:total_pages)   { 100 }

    it "should return the current page number" do
      subject.current_page.should eq current_page
    end
  end

  describe "#total_pages" do
    let(:current_page)  { 20 }
    let(:total_pages)   { 130 }

    it "should return total number of pages in hte photo list" do
      subject.total_pages.should eq total_pages
    end
  end

  describe "#limit_value" do
    let(:photos_per_page) { 15 }
    before do
      Flickr::FlickrAPI.results_per_page = photos_per_page
    end

    it "should return the limit value for the photo list" do
      subject.limit_value.should eq photos_per_page
    end
  end

  def empty_photo_hash
    {
      "photos" => {
        "page"    => 0,
        "pages"   => 0,
        "photo"  => []
      }
    }
  end

  def photo_hash
    {
      "photos" => {
        "page"    => current_page,
        "pages"   => total_pages,
        "photo"  => photo_list
      }
    }
  end

  def photo_list
    [
      {
        "id"     => 1001,
        "farm"   => 2,
        "server" => 1,
        "secret" => 'aaa201',
        "title"  => "photo_1"
      },
      {
        "id"     => 1002,
        "farm"   => 2,
        "server" => 2,
        "secret" => 'aaa202',
        "title"  => "photo_2"
      },
      {
        "id"     => 1003,
        "farm"   => 2,
        "server" => 3,
        "secret" => 'aaa203',
        "title"  => "photo_3"
      }
    ]
  end
end
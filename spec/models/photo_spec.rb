require 'spec_helper'

describe Flickr::Photo do
  let(:id)     { 23443 }
  let(:farm)   { 4 }
  let(:server) { 34 }
  let(:secret) { 'add3453d2' }
  let(:title_hash) { { "title" => "a great photo"} }

  let(:photo_hash) {
    hash = {
      "photo" => {
        "id"   => id,
        "farm" => farm,
        "server" => server,
        "secret" => secret
      }
    }
    hash["photo"].merge!(title_hash)
    hash
  }

  subject { Flickr::Photo.from(photo_hash) }

  describe ".from" do

    context"when title is a string" do

      it "should build the photo model from the hash" do
        subject.id.should eq id
        subject.farm_id.should eq farm
        subject.server_id.should eq server
        subject.secret.should eq secret
        subject.title.should eq title_hash["title"]
      end
    end

    context"when title is hash" do
      let(:title_hash) {
        {
          "title" =>  {
            "_content" => "a great photo"
          }
        }
      }

      it "should extract the title and build the photo model from the hash" do
        subject.id.should eq id
        subject.farm_id.should eq farm
        subject.server_id.should eq server
        subject.secret.should eq secret
        subject.title.should eq title_hash["title"]["_content"]
      end
    end
  end

  describe "#thumbnail_url" do
    let(:title) { {"title" => "a great photo"} }

    it "should generate the url for thumnail size photo" do
      subject.thumbnail_url.should eq "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_t.jpg"
    end
  end

  describe "#large_photo_url" do
    let(:title) { {"title" => "a great photo"} }

    it "should generate url for the large size photo" do
      subject.large_photo_url.should eq "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_z.jpg"
    end
  end
end
require 'rails_helper'

RSpec.describe 'PostTagのモデル', type: :model do
  let(:post_tag) {create(:post_tag)}

  it "post_summary_idとtag_idがある場合、有効であること" do
    expect(post_tag).to be_valid
  end

  it "post_summary_idがない場合、無効であること" do
    post_tag.post_summary_id = nil
    expect(post_tag).to be_invalid
  end

  it "tag_idがない場合、無効であること" do
    post_tag.tag_id = nil
    expect(post_tag).to be_invalid
  end
end
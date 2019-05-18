require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = User.create(
      first_name: "Joe",
      last_name: "taro",
      email: "joetester@example.com",
      password: "password",
    )

    @project = @user.projects.create(
      name: "Test Project",
    )

    @other_user = User.create(
      first_name: "taro",
      last_name: "jiro",
      email: "tester@example.com",
      password: "password",
    )

    @other_project = @other_user.projects.build(
      name: "Test Project",
    )
  end
  it "ユーザー単位では重複したプロジェクト名を許可しないこと" do
    new_project = @user.projects.build(
      name: "Test Project",
    )
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "二人のユーザーが同じ名前を使うことは許可すること" do
    expect(@other_project).to be_valid
  end

  it "名前が空のプロジェクトは許可しない" do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end
end

require 'rails_helper'

RSpec.describe Note, type: :model do
  it "検索文字列に一致するメモを返すこと" do
    user = User.create(
      first_name: "taro",
      last_name: "jiro",
      email: "tester@example.com",
      password: "password",
    )

    project = user.projects.create(
      name: "test project",
    )

    note1 = project.notes.create(
      message: "first test",
      user: user,
    )

    note2 = project.notes.create(
      message: "second test",
      user: user,
    )

    note3 = project.notes.create(
      message: "First test",
      user: user,
    )

    expect(Note.search("first")).to include(note1,note3)
    expect(Note.search("first")).to_not include(note2)
  end

  it "検索結果が1件も見つからなければ空のコレクションを返すこと" do
    user = User.create(
      first_name: "taro",
      last_name: "jiro",
      email: "tester@example.com",
      password: "password",
    )

    project = user.projects.create(
      name: "test project",
    )

    note1 = project.notes.create(
      message: "first test",
      user: user,
    )

    note2 = project.notes.create(
      message: "second test",
      user: user,
    )

    note3 = project.notes.create(
      message: "First test",
      user: user,
    )

    expect(Note.search("message")).to be_empty
  end
end

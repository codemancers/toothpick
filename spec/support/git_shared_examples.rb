shared_examples "it should update, commit and push git" do
  before(:each) do
    Toothpick::Git.should_receive(:new).with(toothpick_home).and_return(git)
    git.should_receive(:update)
    git.should_receive(:commit)
    git.should_receive(:push)
  end
end

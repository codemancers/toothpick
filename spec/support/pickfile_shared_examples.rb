shared_examples "pickfile should be written successfully" do
  before(:each) do
    today_in_utc = Time.now.utc.to_date.strftime

    Kernel.should_receive(:spawn)
      .with("$EDITOR #{toothpick_home}/#{today_in_utc}.md")
      .and_return('pid')
    Process.should_receive(:waitpid).with('pid')
    $?.should_receive(:success?).and_return(true)
    File.should_receive(:exists?).and_return(true)
  end
end

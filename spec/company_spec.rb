RSpec.describe Company do
  let(:user) do
    double(
      :user,
      active_for_company?: true,
      name: "John Doe",
      tokens: 50,
      top_up: 0,
      email_message: "Email sent to john.doe@example.com."
    )
  end

  subject do
    described_class.new(
      id: 1,
      name: "TechCorp",
      top_up: 100,
      email_status: true
    )
  end

  describe "#initialize" do
    it "raises an error when initialized with bad data" do
      expect {
        described_class.new(id: "", name: "Tech Corp", top_up: 50, email_status: true)
      }.to raise_error(ArgumentError, "ID is invalid")
    end
  end

  describe "#process_user" do
    context "when user is active for the company" do
      it "tops up the user tokens and returns a success message" do
        allow(user).to receive(:top_up)
        expected_output = "User: John Doe from TechCorp was topped up with 100 tokens. " \
                          "Total tokens: 50. Email sent to john.doe@example.com."
        expect(subject.process_user(user)).to eq(expected_output)
      end
    end

    context "when user is not active for the company" do
      it "does not process the user" do
        allow(user).to receive(:active_for_company?).and_return(false)
        expect(subject.process_user(user)).to be_nil
      end
    end
  end
end

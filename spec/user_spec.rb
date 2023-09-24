RSpec.describe User do
  let(:company) { double(:company, id: 1, email_status: true) }

  subject do
    described_class.new(
      id: 1,
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      tokens: 50,
      active_status: true,
      company_id: 1,
      email_status: true
    )
  end

  describe "#initialize" do
    it "raises an error when initialized with bad data" do
      expect {
        described_class.new(
          id: "",
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          tokens: 50,
          active_status: true,
          company_id: 1,
          email_status: true
        )
      }.to raise_error(ArgumentError, "ID is invalid")
    end
  end

  describe "#name" do
    it "returns the full name of the user" do
      expect(subject.name).to eq("John Doe")
    end
  end

  describe "#active_for_company?" do
    it "returns true if the user is active for the given company" do
      expect(subject.active_for_company?(company)).to be true
    end
  end

  describe "#top_up" do
    it "increases the tokens by the given amount" do
      expect { subject.top_up(50) }.to change { subject.tokens }.from(50).to(100)
    end
  end

  describe "#email_message" do
    context "when email is allowed" do
      it "returns the email sent message" do
        expect(subject.email_message(company)).to eq("Email sent to john.doe@example.com.")
      end
    end

    context "when email is not allowed" do
      before do
        allow(company).to receive(:email_status).and_return(false)
      end

      it "returns an empty string" do
        expect(subject.email_message(company)).to eq("")
      end
    end
  end
end

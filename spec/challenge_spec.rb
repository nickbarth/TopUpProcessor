RSpec.describe Challenge do
  let(:companies_file) { "companies.json" }
  let(:users_file) { "users.json" }

  describe ".process" do
    context "when provided files are valid" do
      it "does not raise an error" do
        expect { Challenge.process(companies_file, users_file) }.not_to raise_error
      end

      it "generates correct output" do
        Challenge.process(companies_file, users_file)

        generated_output = File.read("output.txt")
        expected_output = File.read("example_output.txt")

        expect(generated_output).to eq(expected_output)
      end
    end

    context "when provided files do not exist" do
      it "raises an error" do
        expect { Challenge.process("nonexistent1.json", "nonexistent2.json") }.to raise_error(Errno::ENOENT)
      end
    end
  end
end

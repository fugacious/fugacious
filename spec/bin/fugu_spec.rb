RSpec.describe 'CLI' do
  USAGE_STRING = "Usage: fug.rb [options] 'Your secret message'"

  describe 'basic CLI usage' do
    it 'provides the usage plus options when no arguments are present' do
      expect(`bin/fugu`).to include(USAGE_STRING)
    end

    it 'provides the usage plus options with the -h or --help argument' do
      expect(`bin/fugu`).to include(USAGE_STRING)
    end
  end
end

class Utilities

  def self.read_remote_csv(url)
    data = []
    CSV.new(open(url), :headers => :first_row).each do |line|
      data << line
    end
    data
  end

end
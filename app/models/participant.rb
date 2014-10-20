class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :student
  serialize :bout_results, Hash

  before_save :add_results

  def add_results
    (1..self.event.participant_count).each do |num|
      if num != self.bout_number
        self.bout_results[num] = nil
      end
    end
  end

end

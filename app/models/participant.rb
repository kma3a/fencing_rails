class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :student
  serialize :bout_results, Hash

  before_create :add_results
  before_save :update_victories, :update_touches_scored

  def add_results
    (1..self.event.participant_count).each do |num|
      if num != self.bout_number
        self.bout_results[num] = 0
      end
    end
  end

  def change_results(bout, result)
    self.bout_results[bout] = result
    self.save
  end

  def update_victories
    victories = 0
    self.bout_results.each_value do |value|
      if value != 0 && value.start_with?("V")
        victories += 1
      end
    end
    self.victories = victories
  end

  def update_touches_scored
    touch = 0
    self.bout_results.each_value do |value|
      touch += value[1].to_i
    end
    self.touches_scored = touch
  end

end

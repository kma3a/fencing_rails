class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :student
  serialize :bout_results, Hash

  before_create :add_results
  before_save :update_victories, :update_touches_scored, :calc_indicator

  def add_results
    (1..self.event.participant_count).each do |num|
      if num != self.bout_number
        self.bout_results[num] = 0
      end
    end
  end

  def update_bout(bout, result)
    change_results(bout, result)
    Participant.find_by({event: self.event.id, bout_number: bout}).update_tr
    get_place
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

  def update_tr
    touch = 0
    self.event.participants.each do |part|
      if part.bout_number != self.bout_number
        touch += part.bout_results[self.bout_number][1].to_i
      end
    end
    self.touches_recieved = touch
    self.save
  end

  def calc_indicator
    self.indicator = (self.touches_scored - self.touches_recieved)
  end

  def get_place
    array = self.event.participants.order(victories: :desc, indicator: :desc, touches_scored: :desc )
    place = array.index(self) + 1
    self.place = place
    self.save
  end

end

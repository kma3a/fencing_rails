class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :student
  serialize :bout_results, Hash

  before_create :add_results
  before_save :update_victories, :update_touches_scored, :calc_indicator

  def update_bout(bout, result)
    edit_bout(bout, result)
  end
  
  def update_tr
    edit_tr
  end

  private

  def add_results
    (1..self.event.participant_count).each do |num|
      self.bout_results[num] = 0 if num != self.bout_number
    end
  end

  def edit_bout(bout, result)
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
      victories += 1 if value != 0 && value.start_with?("V")
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

  
  def calc_indicator
    self.indicator = (self.touches_scored - self.touches_recieved)
  end

  def get_place
    array = self.event.participants.order(victories: :desc, indicator: :desc, touches_scored: :desc )
    array.each_with_index do |part, index|
      part.place = index + 1
      part.save
    end
  end

  def edit_tr
    touch = 0
    self.event.participants.each do |part|
      touch += part.bout_results[self.bout_number][1].to_i if part.bout_number != self.bout_number
    end
    self.touches_recieved = touch
    self.save
  end


end

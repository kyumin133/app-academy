class Card
  # face value
  # face-up vs face-down
  attr_accessor :face_value, :is_face_up

  def initialize(face_value)
    @face_value = face_value
    @is_face_up = false
  end

  def hide
    @is_face_up = false
  end

  def reveal
    @is_face_up = true
  end

  def to_s
    if @is_face_up == false
      return "    ."
    else
      string = ""
      for i in (0...(5 - @face_value.to_s.length)) do
        string += " "
      end
      string += @face_value.to_s
    end
  end

  def ==(other_card)
    return false if other_card == nil
    return true if @face_value == other_card.face_value
    return false
  end
end

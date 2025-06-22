# Click in the text box at the top of the screen to edit the text.
# While not editing the text, press Z to save changes or D to discard changes.
# Up/down moves to different moves/abilities. A/S moves through them quicker.
# X quits.
#
# If you make changes, you will need to go into Debug menu > Other Options... >
# Create PBS File(s) to rewrite the PBS file you want to save the edits to.

#===============================================================================
#
#===============================================================================
module GameData
  class Ability
    attr_writer :real_description
  end

  class Move
    attr_writer :real_description
  end

  class Species
    attr_writer :real_pokedex_entry
  end
end

#===============================================================================
#
#===============================================================================
class DescriptionEditorAbility
  BG_PAGE = "skills"

  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999 + 100
    @background = IconSprite.new(0, 0, @viewport)
    @background.setBitmap("Graphics/UI/Summary/bg")
    @background.z = -1
    @background2 = IconSprite.new(0, 0, @viewport)
    @background2.setBitmap("Graphics/UI/Summary/bg_#{BG_PAGE}")
    @overlay = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay.z = 1
    pbSetSystemFont(@overlay.bitmap)
    @text_box = UIControls::TextBox.new(Graphics.width, 24, @viewport)
    @text_box.box_width = Graphics.width
    @text_box.y = 4
    @text_box.z = 2
    @text_box.set_interactive_rects
    @ability_index = -1
    @ability_keys = GameData::Ability.keys
    change_ability_index(1)
    @disposed = false
  end

  def dispose
    @text_box.dispose
    @background.dispose
    @background2.dispose
    @overlay.dispose
    @viewport.dispose
    @disposed = true
  end

  def disposed?
    return @disposed
  end

  def change_ability_index(offset)
    return if offset == 0
    new_val = [[@ability_index + offset, 0].max, @ability_keys.length - 1].min
    return if @ability_index == new_val
    @ability_index = new_val
    @ability = GameData::Ability.get(@ability_keys[@ability_index])
    @text_box.value = @ability.real_description.clone
    refresh_overlay
  end

  def refresh_overlay
    @overlay.bitmap.clear
    @overlay.bitmap.fill_rect(0, 0, Graphics.width, 32, Color.new(255, 255, 255))
    base   = Color.new(248, 248, 248)
    shadow = Color.new(104, 104, 104)
    textpos = [
      [_INTL("Ability"), 224, 262, :left, base, shadow],
      [sprintf("%d/%d", @ability_index + 1, @ability_keys.length), 458 - 18, 86, :center, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [@ability.name, 328, 262, :left, Color.new(64, 64, 64), Color.new(176, 176, 176)]
    ]
    pbDrawTextPositions(@overlay.bitmap, textpos)
    drawTextEx(@overlay.bitmap, 224, 294, 284, 3, @text_box.value, Color.new(64, 64, 64), Color.new(176, 176, 176))
  end

  def update
    old_text = @text_box.value.clone
    old_busy = @text_box.busy?
    @text_box.update
    @text_box.repaint
    if @text_box.value != old_text
      refresh_overlay
    end
    if !@text_box.busy?
      if Input.repeat?(Input::UP)
        change_ability_index(-1)
      elsif Input.repeat?(Input::DOWN)
        change_ability_index(1)
      elsif Input.repeat?(Input::JUMPUP)
        change_ability_index(-10)
      elsif Input.repeat?(Input::JUMPDOWN)
        change_ability_index(10)
      elsif Input.trigger?(Input::ACTION)
        pbPlayDecisionSE
        @ability.real_description = @text_box.value.clone
      elsif Input.trigger?(Input::SPECIAL)
        @text_box.value = @ability.real_description.clone
        refresh_overlay
      elsif Input.trigger?(Input::BACK)
        pbPlayCancelSE
        dispose
      end
    end
  end
end

#===============================================================================
# Add this to the debug menu.
#===============================================================================
MenuHandlers.add(:debug_menu, :edit_ability_descriptions, {
  "name"        => "Edit ability descriptions",
  "parent"      => :main,
  "description" => "Edit ability descriptions",
  "always_show" => true,
  "effect"      => proc { |sprites, viewport|
    screen = DescriptionEditorAbility.new
    loop do
      Graphics.update
      Input.update
      screen.update
      break if screen.disposed?
    end
  }
})

#===============================================================================
#
#===============================================================================
class DescriptionEditorMove
  BG_PAGE = "moves_detailed"

  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999 + 100
    @background = IconSprite.new(0, 0, @viewport)
    @background.setBitmap("Graphics/UI/Summary/bg_#{BG_PAGE}")
    @overlay = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay.z = 1
    pbSetSystemFont(@overlay.bitmap)
    @text_box = UIControls::TextBox.new(Graphics.width, 24, @viewport)
    @text_box.y = 4
    @text_box.z = 2
    @text_box.set_interactive_rects
    @move_index = -1
    @move_keys = GameData::Move.keys
    change_move_index(1)
    @disposed = false
  end

  def dispose
    @text_box.dispose
    @background.dispose
    @overlay.dispose
    @viewport.dispose
    @disposed = true
  end

  def disposed?
    return @disposed
  end

  def change_move_index(offset)
    return if offset == 0
    new_val = [[@move_index + offset, 0].max, @move_keys.length - 1].min
    return if @move_index == new_val
    @move_index = new_val
    @move = GameData::Move.get(@move_keys[@move_index])
    @text_box.value = @move.real_description.clone
    refresh_overlay
  end

  def refresh_overlay
    @overlay.bitmap.clear
    @overlay.bitmap.fill_rect(0, 0, Graphics.width, 32, Color.new(255, 255, 255))
    base   = Color.new(64, 64, 64)
    shadow = Color.new(176, 176, 176)
    moveBase   = Color.new(64, 64, 64)
    moveShadow = Color.new(176, 176, 176)
    yPos = 104
    textpos = [
      [_INTL("CATEGORY"), 20, 128 - 32, :left, base, shadow],
      [_INTL("POWER"), 20, 160 - 32, :left, base, shadow],
      [_INTL("ACCURACY"), 20, 192 - 32, :left, base, shadow],
      [_INTL("PP"), 342, yPos + 32, :left, moveBase, moveShadow],
      [@move.name, 316, yPos, :left, moveBase, moveShadow],
      [sprintf("%d", @move.total_pp), 460, yPos + 32, :right, moveBase, moveShadow],
      [sprintf("%d/%d", @move_index + 1, @move_keys.length), 383, yPos + 64, :center, moveBase, moveShadow],
    ]
    # Write power and accuracy values for selected move
    case @move.power
    when 0 then textpos.push(["---", 216, 160 - 32, :right, base, shadow])   # Status move
    when 1 then textpos.push(["???", 216, 160 - 32, :right, base, shadow])   # Variable power move
    else        textpos.push([@move.power.to_s, 216, 160 - 32, :right, base, shadow])
    end
    if @move.accuracy == 0
      textpos.push(["---", 216, 192 - 32, :right, base, shadow])
    else
      textpos.push(["#{@move.accuracy}%", 216 + @overlay.bitmap.text_size("%").width, 192 - 32, :right, base, shadow])
    end
    imagepos = []
    type_number = GameData::Type.get(@move.type).icon_position
    imagepos.push([_INTL("Graphics/UI/types"), 248, yPos - 4, 0, type_number * GameData::Type::ICON_SIZE[1], *GameData::Type::ICON_SIZE])
    imagepos.push(["Graphics/UI/category", 166, 124 - 32, 0, @move.category * CATEGORY_ICON_SIZE[1], *CATEGORY_ICON_SIZE])
    pbDrawTextPositions(@overlay.bitmap, textpos)
    pbDrawImagePositions(@overlay.bitmap, imagepos)
    drawTextEx(@overlay.bitmap, 4, 224 - 32, 230, 5 + 1, @text_box.value, moveBase, moveShadow)
  end

  def update
    old_text = @text_box.value.clone
    old_busy = @text_box.busy?
    @text_box.update
    @text_box.repaint
    if @text_box.value != old_text
      refresh_overlay
    end
    if !@text_box.busy?
      if Input.repeat?(Input::UP)
        change_move_index(-1)
      elsif Input.repeat?(Input::DOWN)
        change_move_index(1)
      elsif Input.repeat?(Input::JUMPUP)
        change_move_index(-10)
      elsif Input.repeat?(Input::JUMPDOWN)
        change_move_index(10)
      elsif Input.press?(Input::ACTION)
        pbPlayDecisionSE
        @move.real_description = @text_box.value.clone
      elsif Input.press?(Input::SPECIAL)
        @text_box.value = @move.real_description.clone
        refresh_overlay
      elsif Input.press?(Input::BACK)
        pbPlayCancelSE
        dispose
      end
    end
  end
end

#===============================================================================
# Add this to the debug menu.
#===============================================================================
MenuHandlers.add(:debug_menu, :edit_move_descriptions, {
  "name"        => "Edit move descriptions",
  "parent"      => :main,
  "description" => "Edit move descriptions",
  "always_show" => true,
  "effect"      => proc { |sprites, viewport|
    screen = DescriptionEditorMove.new
    loop do
      Graphics.update
      Input.update
      screen.update
      break if screen.disposed?
    end
  }
})

#===============================================================================
#
#===============================================================================
class DescriptionEditorPokedex
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999 + 100
    @background = IconSprite.new(0, 0, @viewport)
    @background.setBitmap("Graphics/UI/Pokedex/bg_info")
    @overlay = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay.z = 1
    pbSetSystemFont(@overlay.bitmap)
    @text_box = UIControls::TextBox.new(Graphics.width, 24, @viewport)
    @text_box.y = 4
    @text_box.z = 2
    @text_box.set_interactive_rects
    @species_index = -1
    @species_keys = GameData::Species.keys
    change_species_index(1)
    @disposed = false
  end

  def dispose
    @text_box.dispose
    @background.dispose
    @overlay.dispose
    @viewport.dispose
    @disposed = true
  end

  def disposed?
    return @disposed
  end

  def change_species_index(offset)
    return if offset == 0
    new_val = [[@species_index + offset, 0].max, @species_keys.length - 1].min
    return if @species_index == new_val
    @species_index = new_val
    @species = GameData::Species.get(@species_keys[@species_index])
    @text_box.value = @species.real_pokedex_entry.clone
    refresh_overlay
  end

  def refresh_overlay
    @overlay.bitmap.clear
    @overlay.bitmap.fill_rect(0, 0, Graphics.width, 32, Color.new(255, 255, 255))
    base   = Color.new(88, 88, 80)
    shadow = Color.new(168, 184, 184)
    textpos = [
      [@species.name, 246, 48, :left, Color.new(248, 248, 248), Color.black],
      [sprintf("%d/%d", @species_index + 1, @species_keys.length), 246, 80, :left, base, shadow],
    ]
    pbDrawTextPositions(@overlay.bitmap, textpos)
    drawTextEx(@overlay.bitmap, 40, 246 - 32, Graphics.width - 80, 4,   # overlay, x, y, width, num lines
              @text_box.value, base, shadow)
  end

  def update
    old_text = @text_box.value.clone
    old_busy = @text_box.busy?
    @text_box.update
    @text_box.repaint
    if @text_box.value != old_text
      refresh_overlay
    end
    if !@text_box.busy?
      if Input.repeat?(Input::UP)
        change_species_index(-1)
      elsif Input.repeat?(Input::DOWN)
        change_species_index(1)
      elsif Input.repeat?(Input::JUMPUP)
        change_species_index(-10)
      elsif Input.repeat?(Input::JUMPDOWN)
        change_species_index(10)
      elsif Input.press?(Input::ACTION)
        pbPlayDecisionSE
        @species.real_pokedex_entry = @text_box.value.clone
      elsif Input.press?(Input::SPECIAL)
        @text_box.value = @species.real_pokedex_entry.clone
        refresh_overlay
      elsif Input.press?(Input::BACK)
        pbPlayCancelSE
        dispose
      end
    end
  end
end

#===============================================================================
# Add this to the debug menu.
#===============================================================================
# MenuHandlers.add(:debug_menu, :edit_pokedex_descriptions, {
#   "name"        => "Edit Pokédex descriptions",
#   "parent"      => :main,
#   "description" => "Edit Pokédex descriptions",
#   "always_show" => true,
#   "effect"      => proc { |sprites, viewport|
#     screen = DescriptionEditorPokedex.new
#     loop do
#       Graphics.update
#       Input.update
#       screen.update
#       break if screen.disposed?
#     end
#   }
# })

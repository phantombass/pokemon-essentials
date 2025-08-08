#===============================================================================
#
#===============================================================================
module PBEffects
  #-----------------------------------------------------------------------------
  # These effects apply to a battler.
  #-----------------------------------------------------------------------------

  AllySwitchRate      = 0
  AquaRing            = 1
  Attract             = 2
  BanefulBunker       = 3
  BeakBlast           = 4
  Bide                = 5
  BideDamage          = 6
  BideTarget          = 7
  BurningBulwark      = 8
  BurnUp              = 9
  Charge              = 10
  ChoiceBand          = 11
  Confusion           = 12
  Counter             = 13
  CounterTarget       = 14
  Curse               = 15
  Dancer              = 16
  DefenseCurl         = 17
  DestinyBond         = 18
  DestinyBondPrevious = 19
  DestinyBondTarget   = 20
  Disable             = 21
  DisableMove         = 22
  DoubleShock         = 23
  Electrify           = 24
  Embargo             = 25
  Encore              = 26
  EncoreMove          = 27
  Endure              = 28
  ExtraType           = 29
  FirstPledge         = 30
  FlashFire           = 31
  Flinch              = 32
  FocusEnergy         = 33
  FocusPunch          = 34
  FollowMe            = 35
  Foresight           = 36
  FuryCutter          = 37
  GastroAcid          = 38
  GemConsumed         = 39
  GigatonHammer       = 40
  Grudge              = 41
  HealBlock           = 42
  HelpingHand         = 43
  HyperBeam           = 44
  Illusion            = 45
  Imprison            = 46
  Ingrain             = 47
  Instruct            = 48
  Instructed          = 49
  JawLock             = 50
  KingsShield         = 51
  LaserFocus          = 52
  LeechSeed           = 53
  LockOn              = 54
  LockOnPos           = 55
  MagicBounce         = 56
  MagicCoat           = 57
  MagnetRise          = 58
  MeanLook            = 59
  MeFirst             = 60
  Metronome           = 61
  MicleBerry          = 62
  Minimize            = 63
  MiracleEye          = 64
  MirrorCoat          = 65
  MirrorCoatTarget    = 66
  MoveNext            = 67
  MudSport            = 68
  Nightmare           = 69
  NoRetreat           = 70
  Obstruct            = 71
  Octolock            = 72
  Outrage             = 73
  ParentalBond        = 74
  PerishSong          = 75
  PerishSongUser      = 76
  PickupItem          = 77
  PickupUse           = 78
  Pinch               = 79   # Battle Palace only
  Powder              = 80
  PowerTrick          = 81
  Prankster           = 82
  PriorityAbility     = 83
  PriorityItem        = 84
  Protect             = 85
  ProtectRate         = 86
  Quash               = 87
  Rage                = 88
  RagePowder          = 89   # Used along with FollowMe
  Rollout             = 90
  Roost               = 91
  SaltCure            = 92
  ShedTail            = 93   # Just prevents Substitute resetting upon switch
  ShellTrap           = 94
  SilkTrap            = 95
  SkyDrop             = 96
  SlowStart           = 97
  SmackDown           = 98
  Snatch              = 99
  SpikyShield         = 100
  Spotlight           = 101
  Stockpile           = 102
  StockpileDef        = 103
  StockpileSpDef      = 104
  Substitute          = 105
  SyrupBomb           = 106
  SyrupBombUser       = 107
  TarShot             = 108
  Taunt               = 109
  Telekinesis         = 110
  ThroatChop          = 111
  Torment             = 112
  Toxic               = 113
  Transform           = 114
  TransformSpecies    = 115
  Trapping            = 116   # Trapping move that deals EOR damage
  TrappingMove        = 117
  TrappingUser        = 118
  Truant              = 119
  TwoTurnAttack       = 120
  Unburden            = 121
  Uproar              = 122
  Vulnerable          = 123
  WaterSport          = 124
  WeightChange        = 125
  Yawn                = 126

  #-----------------------------------------------------------------------------
  # These effects apply to a battler position.
  #-----------------------------------------------------------------------------

  FutureSightCounter        = 700
  FutureSightMove           = 701
  FutureSightUserIndex      = 702
  FutureSightUserPartyIndex = 703
  HealingWish               = 704
  LunarDance                = 705
  Wish                      = 706
  WishAmount                = 707
  WishMaker                 = 708

  #-----------------------------------------------------------------------------
  # These effects apply to a side.
  #-----------------------------------------------------------------------------

  AuroraVeil         = 800
  CraftyShield       = 801
  EchoedVoiceCounter = 802
  EchoedVoiceUsed    = 803
  LastRoundFainted   = 804
  LightScreen        = 805
  LuckyChant         = 806
  MatBlock           = 807
  Mist               = 808
  QuickGuard         = 809
  Rainbow            = 810
  Reflect            = 811
  Round              = 812
  Safeguard          = 813
  SeaOfFire          = 814
  Spikes             = 815
  StealthRock        = 816
  StickyWeb          = 817
  Swamp              = 818
  Tailwind           = 819
  ToxicSpikes        = 820
  WideGuard          = 821

  #-----------------------------------------------------------------------------
  # These effects apply to the battle (i.e. both sides).
  #-----------------------------------------------------------------------------

  AmuletCoin      = 900
  FairyLock       = 901
  FusionBolt      = 902
  FusionFlare     = 903
  Gravity         = 904
  HappyHour       = 905
  IonDeluge       = 906
  MagicRoom       = 907
  MudSportField   = 908
  PayDay          = 909
  TrickRoom       = 910
  WaterSportField = 911
  WonderRoom      = 912
end

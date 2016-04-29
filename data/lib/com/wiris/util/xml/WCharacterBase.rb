
class WCharacterBase
  def initialize()
    super()
  end
  NEGATIVE_THIN_SPACE = 57344
  ROOT = 61696
  ROOT_VERTICAL = 61727
  ROOT_NO_TAIL = 61728
  ROOT_NO_TAIL_VERTICAL = 61759
  ROOT_LEFT_TAIL = 61760
  ROOT_VERTICAL_LINE = 61761
  ROUND_BRACKET_LEFT = 40
  ROUND_BRACKET_RIGHT = 41
  COMMA = 44
  FULL_STOP = 46
  SQUARE_BRACKET_LEFT = 91
  SQUARE_BRACKET_RIGHT = 93
  CIRCUMFLEX_ACCENT = 94
  LOW_LINE = 95
  CURLY_BRACKET_LEFT = 123
  VERTICAL_BAR = 124
  CURLY_BRACKET_RIGHT = 125
  TILDE = 126
  MACRON = 175
  COMBINING_LOW_LINE = 818
  MODIFIER_LETTER_CIRCUMFLEX_ACCENT = 710
  CARON = 711
  EN_QUAD = 8192
  EM_QUAD = 8193
  EN_SPACE = 8194
  EM_SPACE = 8195
  THICK_SPACE = 8196
  MID_SPACE = 8197
  SIX_PER_EM_SPACE = 8198
  FIGIRE_SPACE = 8199
  PUNCTUATION_SPACE = 8200
  THIN_SPACE = 8201
  HAIR_SPACE = 8202
  ZERO_WIDTH_SPACE = 8203
  ZERO_WIDTH_NON_JOINER = 8204
  ZERO_WIDTH_JOINER = 8205
  DOUBLE_VERTICAL_BAR = 8214
  DOUBLE_HORIZONTAL_BAR = 9552
  NARROW_NO_BREAK_SPACE = 8239
  MEDIUM_MATHEMATICAL_SPACE = 8287
  WORD_JOINER = 8288
  PLANCKOVER2PI = 8463
  LEFTWARDS_ARROW = 8592
  UPWARDS_ARROW = 8593
  RIGHTWARDS_ARROW = 8594
  DOWNWARDS_ARROW = 8595
  LEFTRIGHT_ARROW = 8596
  UP_DOWN_ARROW = 8597
  LEFTWARDS_ARROW_FROM_BAR = 8612
  RIGHTWARDS_ARROW_FROM_BAR = 8614
  LEFTWARDS_ARROW_WITH_HOOK = 8617
  RIGHTWARDS_ARROW_WITH_HOOK = 8618
  LEFTWARDS_HARPOON_WITH_BARB_UPWARDS = 8636
  RIGHTWARDS_HARPOON_WITH_BARB_UPWARDS = 8640
  LEFTWARDS_DOUBLE_ARROW = 8656
  RIGHTWARDS_DOUBLE_ARROW = 8658
  LEFT_RIGHT_DOUBLE_ARROW = 8660
  LEFTWARDS_ARROW_OVER_RIGHTWARDS_ARROW = 8646
  RIGHTWARDS_ARROW_OVER_LEFTWARDS_ARROW = 8644
  LEFTWARDS_HARPOON_OVER_RIGHTWARDS_HARPOON = 8651
  RIGHTWARDS_HARPOON_OVER_LEFTWARDS_HARPOON = 8652
  LONG_RIGHTWARDS_ARROW = 10230
  LONG_LEFTWARDS_ARROW = 10229
  LONG_LEFT_RIGHT_ARROW = 10231
  LONG_LEFTWARDS_DOUBLE_ARROW = 10232
  LONG_RIGHTWARDS_DOUBLE_ARROW = 10233
  LONG_LEFT_RIGHT_DOUBLE_ARROW = 10234
  TILDE_OPERATOR = 8764
  LEFT_CEILING = 8968
  RIGHT_CEILING = 8969
  LEFT_FLOOR = 8970
  RIGHT_FLOOR = 8971
  TOP_PARENTHESIS = 9180
  BOTTOM_PARENTHESIS = 9181
  TOP_SQUARE_BRACKET = 9140
  BOTTOM_SQUARE_BRACKET = 9141
  TOP_CURLY_BRACKET = 9182
  BOTTOM_CURLY_BRACKET = 9183
  MATHEMATICAL_LEFT_ANGLE_BRACKET = 10216
  MATHEMATICAL_RIGHT_ANGLE_BRACKET = 10217
  DOUBLE_STRUCK_ITALIC_CAPITAL_D = 8517
  DOUBLE_STRUCK_ITALIC_SMALL_D = 8518
  DOUBLE_STRUCK_ITALIC_SMALL_E = 8519
  DOUBLE_STRUCK_ITALIC_SMALL_I = 8520
  EPSILON = 949
  VAREPSILON = 1013
  def self.isDigit(c)
    if (48<=c)&&(c<=57)
      return true
    end
    if (1632<=c)&&(c<=1641)
      return true
    end
    if (1776<=c)&&(c<=1785)
      return true
    end
    if (2790<=c)&&(c<=2799)
      return true
    end
    return false
  end
  def self.isIdentifier(c)
    return isLetter(c)||(c==95)
  end
  def self.isLarge(c)
    return binarySearch(largeOps,c)
  end
  def self.isVeryLarge(c)
    return binarySearch(veryLargeOps,c)
  end
  def self.isBinaryOp(c)
    return binarySearch(binaryOps,c)
  end
  def self.isRelation(c)
    return binarySearch(relations,c)
  end
  def self.binarySearch(v,c)
    min = 0
    max = v::length-1
    loop do
      mid = ((min+max)/2)
      cc = v[mid]
      if c==cc
        return true
      else 
        if c<cc
          max = mid-1
        else 
          min = mid+1
        end
      end
    break if not min<=max
    end
    return false
  end
  @@binaryOps = [43, 45, 47, 177, 183, 215, 247, 8226, 8722, 8723, 8724, 8726, 8727, 8728, 8743, 8744, 8745, 8746, 8760, 8768, 8846, 8851, 8852, 8853, 8854, 8855, 8856, 8857, 8858, 8859, 8861, 8862, 8863, 8864, 8865, 8890, 8891, 8900, 8901, 8902, 8903, 8905, 8906, 8907, 8908, 8910, 8911, 8914, 8915, 8966, 9021, 9675, 10678, 10789, 10794, 10797, 10798, 10799, 10804, 10805, 10812, 10815, 10835, 10836, 10837, 10838, 10846, 10847, 10851]
  def self.binaryOps
    @@binaryOps
  end
  def self.binaryOps=(binaryOps)
    @@binaryOps=binaryOps
  end
  @@relations = [60, 61, 62, 8592, 8593, 8594, 8595, 8596, 8597, 8598, 8599, 8600, 8601, 8602, 8603, 8604, 8605, 8606, 8608, 8610, 8611, 8614, 8617, 8618, 8619, 8620, 8621, 8622, 8624, 8625, 8627, 8630, 8631, 8636, 8637, 8638, 8639, 8640, 8641, 8642, 8643, 8644, 8645, 8646, 8647, 8648, 8649, 8650, 8651, 8652, 8653, 8654, 8655, 8656, 8657, 8658, 8659, 8660, 8661, 8666, 8667, 8669, 8693, 8712, 8713, 8715, 8716, 8733, 8739, 8740, 8741, 8742, 8764, 8765, 8769, 8770, 8771, 8772, 8773, 8774, 8775, 8776, 8777, 8778, 8779, 8781, 8782, 8783, 8784, 8785, 8786, 8787, 8788, 8789, 8790, 8791, 8793, 8794, 8795, 8796, 8799, 8800, 8801, 8802, 8804, 8805, 8806, 8807, 8808, 8809, 8810, 8811, 8812, 8814, 8815, 8816, 8817, 8818, 8819, 8820, 8821, 8822, 8823, 8824, 8825, 8826, 8827, 8828, 8829, 8830, 8831, 8832, 8833, 8834, 8835, 8836, 8837, 8838, 8839, 8840, 8841, 8842, 8843, 8847, 8848, 8849, 8850, 8866, 8867, 8869, 8871, 8872, 8873, 8874, 8875, 8876, 8877, 8878, 8879, 8882, 8883, 8884, 8885, 8886, 8887, 8888, 8904, 8909, 8912, 8913, 8918, 8919, 8920, 8921, 8922, 8923, 8926, 8927, 8930, 8931, 8934, 8935, 8936, 8937, 8938, 8939, 8940, 8941, 8994, 8995, 9123, 10229, 10230, 10231, 10232, 10233, 10234, 10236, 10239, 10501, 10514, 10515, 10531, 10532, 10533, 10534, 10535, 10536, 10537, 10538, 10547, 10550, 10551, 10560, 10561, 10562, 10564, 10567, 10574, 10575, 10576, 10577, 10578, 10579, 10580, 10581, 10582, 10583, 10584, 10585, 10586, 10587, 10588, 10589, 10590, 10591, 10592, 10593, 10606, 10607, 10608, 10620, 10621, 10869, 10877, 10878, 10885, 10886, 10887, 10888, 10889, 10890, 10891, 10892, 10901, 10902, 10909, 10910, 10913, 10914, 10927, 10928, 10933, 10934, 10935, 10936, 10937, 10938, 10949, 10950, 10955, 10956, 10987, 11005]
  def self.relations
    @@relations
  end
  def self.relations=(relations)
    @@relations=relations
  end
  @@largeOps = [8719, 8720, 8721, 8896, 8897, 8898, 8899, 10756, 10757, 10758, 10759, 10760]
  def self.largeOps
    @@largeOps
  end
  def self.largeOps=(largeOps)
    @@largeOps=largeOps
  end
  @@veryLargeOps = [8747, 8748, 8749, 8750, 8751, 8752, 8753, 8754, 8755, 10763, 10764, 10765, 10766, 10767, 10768, 10774, 10775, 10776, 10777, 10778, 10779, 10780]
  def self.veryLargeOps
    @@veryLargeOps
  end
  def self.veryLargeOps=(veryLargeOps)
    @@veryLargeOps=veryLargeOps
  end
  @@tallLetters = [98, 100, 102, 104, 105, 106, 107, 108, 116, 946, 948, 950, 952, 955, 958]
  def self.tallLetters
    @@tallLetters
  end
  def self.tallLetters=(tallLetters)
    @@tallLetters=tallLetters
  end
  @@longLetters = [103, 106, 112, 113, 121, 946, 947, 950, 951, 956, 958, 961, 962, 966, 967, 968]
  def self.longLetters
    @@longLetters
  end
  def self.longLetters=(longLetters)
    @@longLetters=longLetters
  end
  @@negations = [61, 8800, 8801, 8802, 8764, 8769, 8712, 8713, 8715, 8716, 8834, 8836, 8835, 8837, 8838, 8840, 8839, 8841, 62, 8815, 60, 8814, 8805, 8817, 8804, 8816, 10878, 8817, 10877, 8816, 8776, 8777, 8771, 8772, 8773, 8775, 8849, 8930, 8850, 8931, 8707, 8708, 8741, 8742]
  def self.negations
    @@negations
  end
  def self.negations=(negations)
    @@negations=negations
  end
  @@mirrorDictionary = [40, 41, 41, 40, 60, 62, 62, 60, 91, 93, 93, 91, 123, 125, 125, 123, 171, 187, 187, 171, 3898, 3899, 3899, 3898, 3900, 3901, 3901, 3900, 5787, 5788, 5788, 5787, 8249, 8250, 8250, 8249, 8261, 8262, 8262, 8261, 8317, 8318, 8318, 8317, 8333, 8334, 8334, 8333, 8712, 8715, 8713, 8716, 8714, 8717, 8715, 8712, 8716, 8713, 8717, 8714, 8725, 10741, 8764, 8765, 8765, 8764, 8771, 8909, 8786, 8787, 8787, 8786, 8788, 8789, 8789, 8788, 8804, 8805, 8805, 8804, 8806, 8807, 8807, 8806, 8808, 8809, 8809, 8808, 8810, 8811, 8811, 8810, 8814, 8815, 8815, 8814, 8816, 8817, 8817, 8816, 8818, 8819, 8819, 8818, 8820, 8821, 8821, 8820, 8822, 8823, 8823, 8822, 8824, 8825, 8825, 8824, 8826, 8827, 8827, 8826, 8828, 8829, 8829, 8828, 8830, 8831, 8831, 8830, 8832, 8833, 8833, 8832, 8834, 8835, 8835, 8834, 8836, 8837, 8837, 8836, 8838, 8839, 8839, 8838, 8840, 8841, 8841, 8840, 8842, 8843, 8843, 8842, 8847, 8848, 8848, 8847, 8849, 8850, 8850, 8849, 8856, 10680, 8866, 8867, 8867, 8866, 8870, 10974, 8872, 10980, 8873, 10979, 8875, 10981, 8880, 8881, 8881, 8880, 8882, 8883, 8883, 8882, 8884, 8885, 8885, 8884, 8886, 8887, 8887, 8886, 8905, 8906, 8906, 8905, 8907, 8908, 8908, 8907, 8909, 8771, 8912, 8913, 8913, 8912, 8918, 8919, 8919, 8918, 8920, 8921, 8921, 8920, 8922, 8923, 8923, 8922, 8924, 8925, 8925, 8924, 8926, 8927, 8927, 8926, 8928, 8929, 8929, 8928, 8930, 8931, 8931, 8930, 8932, 8933, 8933, 8932, 8934, 8935, 8935, 8934, 8936, 8937, 8937, 8936, 8938, 8939, 8939, 8938, 8940, 8941, 8941, 8940, 8944, 8945, 8945, 8944, 8946, 8954, 8947, 8955, 8948, 8956, 8950, 8957, 8951, 8958, 8954, 8946, 8955, 8947, 8956, 8948, 8957, 8950, 8958, 8951, 8968, 8969, 8969, 8968, 8970, 8971, 8971, 8970, 9001, 9002, 9002, 9001, 10088, 10089, 10089, 10088, 10090, 10091, 10091, 10090, 10092, 10093, 10093, 10092, 10094, 10095, 10095, 10094, 10096, 10097, 10097, 10096, 10098, 10099, 10099, 10098, 10100, 10101, 10101, 10100, 10179, 10180, 10180, 10179, 10181, 10182, 10182, 10181, 10184, 10185, 10185, 10184, 10187, 10189, 10189, 10187, 10197, 10198, 10198, 10197, 10205, 10206, 10206, 10205, 10210, 10211, 10211, 10210, 10212, 10213, 10213, 10212, 10214, 10215, 10215, 10214, 10216, 10217, 10217, 10216, 10218, 10219, 10219, 10218, 10220, 10221, 10221, 10220, 10222, 10223, 10223, 10222, 10627, 10628, 10628, 10627, 10629, 10630, 10630, 10629, 10631, 10632, 10632, 10631, 10633, 10634, 10634, 10633, 10635, 10636, 10636, 10635, 10637, 10640, 10638, 10639, 10639, 10638, 10640, 10637, 10641, 10642, 10642, 10641, 10643, 10644, 10644, 10643, 10645, 10646, 10646, 10645, 10647, 10648, 10648, 10647, 10680, 8856, 10688, 10689, 10689, 10688, 10692, 10693, 10693, 10692, 10703, 10704, 10704, 10703, 10705, 10706, 10706, 10705, 10708, 10709, 10709, 10708, 10712, 10713, 10713, 10712, 10714, 10715, 10715, 10714, 10741, 8725, 10744, 10745, 10745, 10744, 10748, 10749, 10749, 10748, 10795, 10796, 10796, 10795, 10797, 10798, 10798, 10797, 10804, 10805, 10805, 10804, 10812, 10813, 10813, 10812, 10852, 10853, 10853, 10852, 10873, 10874, 10874, 10873, 10877, 10878, 10878, 10877, 10879, 10880, 10880, 10879, 10881, 10882, 10882, 10881, 10883, 10884, 10884, 10883, 10891, 10892, 10892, 10891, 10897, 10898, 10898, 10897, 10899, 10900, 10900, 10899, 10901, 10902, 10902, 10901, 10903, 10904, 10904, 10903, 10905, 10906, 10906, 10905, 10907, 10908, 10908, 10907, 10913, 10914, 10914, 10913, 10918, 10919, 10919, 10918, 10920, 10921, 10921, 10920, 10922, 10923, 10923, 10922, 10924, 10925, 10925, 10924, 10927, 10928, 10928, 10927, 10931, 10932, 10932, 10931, 10939, 10940, 10940, 10939, 10941, 10942, 10942, 10941, 10943, 10944, 10944, 10943, 10945, 10946, 10946, 10945, 10947, 10948, 10948, 10947, 10949, 10950, 10950, 10949, 10957, 10958, 10958, 10957, 10959, 10960, 10960, 10959, 10961, 10962, 10962, 10961, 10963, 10964, 10964, 10963, 10965, 10966, 10966, 10965, 10974, 8870, 10979, 8873, 10980, 8872, 10981, 8875, 10988, 10989, 10989, 10988, 10999, 11000, 11000, 10999, 11001, 11002, 11002, 11001, 11778, 11779, 11779, 11778, 11780, 11781, 11781, 11780, 11785, 11786, 11786, 11785, 11788, 11789, 11789, 11788, 11804, 11805, 11805, 11804, 11808, 11809, 11809, 11808, 11810, 11811, 11811, 11810, 11812, 11813, 11813, 11812, 11814, 11815, 11815, 11814, 11816, 11817, 11817, 11816, 12296, 12297, 12297, 12296, 12298, 12299, 12299, 12298, 12300, 12301, 12301, 12300, 12302, 12303, 12303, 12302, 12304, 12305, 12305, 12304, 12308, 12309, 12309, 12308, 12310, 12311, 12311, 12310, 12312, 12313, 12313, 12312, 12314, 12315, 12315, 12314, 65113, 65114, 65114, 65113, 65115, 65116, 65116, 65115, 65117, 65118, 65118, 65117, 65124, 65125, 65125, 65124, 65288, 65289, 65289, 65288, 65308, 65310, 65310, 65308, 65339, 65341, 65341, 65339, 65371, 65373, 65373, 65371, 65375, 65376, 65376, 65375, 65378, 65379, 65379, 65378, 9115, 9118, 9116, 9119, 9117, 9120, 9118, 9115, 9119, 9116, 9120, 9117, 9121, 9124, 9122, 9125, 9123, 9126, 9124, 9121, 9125, 9122, 9126, 9123, 9127, 9131, 9130, 9134, 9129, 9133, 9131, 9127, 9134, 9130, 9133, 9129, 9128, 9132, 9132, 9128]
  def self.mirrorDictionary
    @@mirrorDictionary
  end
  def self.mirrorDictionary=(mirrorDictionary)
    @@mirrorDictionary=mirrorDictionary
  end
  @@horizontalLTRStretchyChars = [WCharacterBase::LEFTWARDS_ARROW, WCharacterBase::RIGHTWARDS_ARROW, WCharacterBase::LEFTRIGHT_ARROW, WCharacterBase::LEFTWARDS_ARROW_FROM_BAR, WCharacterBase::RIGHTWARDS_ARROW_FROM_BAR, WCharacterBase::LEFTWARDS_ARROW_WITH_HOOK, WCharacterBase::RIGHTWARDS_ARROW_WITH_HOOK, WCharacterBase::LEFTWARDS_HARPOON_WITH_BARB_UPWARDS, WCharacterBase::RIGHTWARDS_HARPOON_WITH_BARB_UPWARDS, WCharacterBase::LEFTWARDS_DOUBLE_ARROW, WCharacterBase::RIGHTWARDS_DOUBLE_ARROW, WCharacterBase::TOP_CURLY_BRACKET, WCharacterBase::BOTTOM_CURLY_BRACKET, WCharacterBase::TOP_PARENTHESIS, WCharacterBase::BOTTOM_PARENTHESIS, WCharacterBase::TOP_SQUARE_BRACKET, WCharacterBase::BOTTOM_SQUARE_BRACKET, WCharacterBase::LEFTWARDS_ARROW_OVER_RIGHTWARDS_ARROW, WCharacterBase::RIGHTWARDS_ARROW_OVER_LEFTWARDS_ARROW, WCharacterBase::LEFTWARDS_HARPOON_OVER_RIGHTWARDS_HARPOON, WCharacterBase::RIGHTWARDS_HARPOON_OVER_LEFTWARDS_HARPOON]
  def self.horizontalLTRStretchyChars
    @@horizontalLTRStretchyChars
  end
  def self.horizontalLTRStretchyChars=(horizontalLTRStretchyChars)
    @@horizontalLTRStretchyChars=horizontalLTRStretchyChars
  end
  @@tallAccents = [WCharacterBase::LEFTWARDS_ARROW_OVER_RIGHTWARDS_ARROW, WCharacterBase::RIGHTWARDS_ARROW_OVER_LEFTWARDS_ARROW, WCharacterBase::LEFTWARDS_HARPOON_OVER_RIGHTWARDS_HARPOON, WCharacterBase::RIGHTWARDS_HARPOON_OVER_LEFTWARDS_HARPOON]
  def self.tallAccents
    @@tallAccents
  end
  def self.tallAccents=(tallAccents)
    @@tallAccents=tallAccents
  end
  @@invisible = [8289, 8290, 8291]
  def self.invisible
    @@invisible
  end
  def self.invisible=(invisible)
    @@invisible=invisible
  end
  def self.getMirror(str)
    mirroredStr = ""
    i = 0
    while i<str::length()
      c = Std::charCodeAt(str,i)
      j = 0
      while j<WCharacterBase::mirrorDictionary::length
        if c==WCharacterBase::mirrorDictionary[j]
          c = WCharacterBase::mirrorDictionary[j + 1]
          break
        end
        j+=2
      end
      mirroredStr+=Std::fromCharCode(c)
      i+=1
    end
    return mirroredStr
  end
  def self.isStretchyLTR(c)
    i = 0
    while i<WCharacterBase::horizontalLTRStretchyChars::length
      if c==WCharacterBase::horizontalLTRStretchyChars[i]
        return true
      end
      i+=1
    end
    return false
  end
  def self.getNegated(c)
    i = 0
    while i<WCharacterBase::negations::length
      if WCharacterBase::negations[i]==c
        return WCharacterBase::negations[i + 1]
      end
      i+=2
    end
    return -1
  end
  def self.getNotNegated(c)
    i = 1
    while i<WCharacterBase::negations::length
      if WCharacterBase::negations[i]==c
        return WCharacterBase::negations[i - 1]
      end
      i+=2
    end
    return -1
  end
  def self.isLetter(c)
    if isDigit(c)
      return false
    end
    if (65<=c)&&(c<=90)
      return true
    end
    if (97<=c)&&(c<=122)
      return true
    end
    if (((192<=c)&&(c<=696))&&(c!=215))&&(c!=247)
      return true
    end
    if (867<=c)&&(c<=1521)
      return true
    end
    if (1552<=c)&&(c<=8188)
      return true
    end
    if ((((c==8472)||(c==8467))||isDoubleStruck(c))||isFraktur(c))||isScript(c)
      return true
    end
    if isChinese(c)
      return true
    end
    if isKorean(c)
      return true
    end
    return false
  end
  def self.isUnicodeMathvariant(c)
    return ((isDoubleStruck(c)||isFraktur(c))||isScript(c))
  end
  def self.isRequiredByQuizzes(c)
    return ((((((((c==120128)||(c==8450))||(c==8461))||(c==8469))||(c==8473))||(c==8474))||(c==8477))||(c==8484))
  end
  def self.isDoubleStruck(c)
    return (((((((((c>=120120)&&(c<=120171))||(c==8450))||(c==8461))||(c==8469))||(c==8473))||(c==8474))||(c==8477))||(c==8484))
  end
  def self.isFraktur(c)
    return (((((((c>=120068)&&(c<=120119))||(c==8493))||(c==8460))||(c==8465))||(c==8476))||(c==8488))
  end
  def self.isScript(c)
    return (((((((((((((c>=119964)&&(c<=120015))||(c==8458))||(c==8459))||(c==8466))||(c==8464))||(c==8499))||(c==8500))||(c==8492))||(c==8495))||(c==8496))||(c==8497))||(c==8475))
  end
  def self.isLowerCase(c)
    return (((((c>=97)&&(c<=122))||((c>=224)&&(c<=255)))||((c>=591)&&(c>=659)))||((c>=661)&&(c<=687)))||((c>=940)&&(c<=974))
  end
  def self.isWord(c)
    if ((((isDevanagari(c)||isChinese(c))||isHebrew(c))||isThai(c))||isGujarati(c))||isKorean(c)
      return true
    end
    return false
  end
  def self.isArabianString(s)
    i = s::length()-1
    while i>=0
      if !isArabian(Std::charCodeAt(s,i))
        return false
      end
      i-=1
    end
    return true
  end
  def self.isArabian(c)
    if ((c>=1536)&&(c<=1791))&&!WCharacterBase::isDigit(c)
      return true
    end
    return false
  end
  def self.isHebrew(c)
    if (c>=1424)&&(c<=1535)
      return true
    end
    return false
  end
  def self.isChinese(c)
    if (c>=13312)&&(c<=40959)
      return true
    end
    return false
  end
  def self.isKorean(c)
    if (c>=12593)&&(c<=52044)
      return true
    end
    return false
  end
  def self.isGreek(c)
    if (c>=945)&&(c<=969)
      return true
    else 
      if ((c>=913)&&(c<=937))&&(c!=930)
        return true
      else 
        if ((c==977)||(c==981))||(c==982)
          return true
        end
      end
    end
    return false
  end
  def self.isDevanagari(c)
    if (c>=2304)&&(c<2431)
      return true
    end
    return false
  end
  def self.isGujarati(c)
    if (((c>=2689)&&(c<2788))||(c==2800))||(c==2801)
      return true
    end
    return false
  end
  def self.isThai(c)
    if (3585<=c)&&(c<3676)
      return true
    end
    return false
  end
  def self.isDevanagariString(s)
    i = s::length()-1
    while i>=0
      if !isDevanagari(Std::charCodeAt(s,i))
        return false
      end
      i-=1
    end
    return true
  end
  def self.isRTL(c)
    if isHebrew(c)||isArabian(c)
      return true
    end
    return false
  end
  def self.isTallLetter(c)
    if ((97<=c)&&(c<=122))||((945<=c)&&(c<=969))
      return (WCharacterBase::binarySearch(@@tallLetters,c))
    end
    return true
  end
  def self.isLongLetter(c)
    if ((97<=c)&&(c<=122))||((945<=c)&&(c<=969))
      return (WCharacterBase::binarySearch(@@longLetters,c))
    else 
      if (65<=c)&&(c<=90)
        return false
      end
    end
    return true
  end
  def self.isInvisible(c)
    return binarySearch(@@invisible,c)
  end
  @@horizontalOperators = [175, 818, 8592, 8594, 8596, 8612, 8614, 8617, 8618, 8636, 8640, 8656, 8658, 8660, 8764, 9140, 9141, 9180, 9181, 9182, 9183, 9552]
  def self.horizontalOperators
    @@horizontalOperators
  end
  def self.horizontalOperators=(horizontalOperators)
    @@horizontalOperators=horizontalOperators
  end
  def self.isHorizontalOperator(c)
    return binarySearch(@@horizontalOperators,c)
  end
  @@latinLetters = "@0065@0066@0067@0068@0069@0070@0071@0072@0073@0074@0075@0076@0077@0078@0079@0080@0081@0082@0083@0084@0085@0086@0087@0088@0089@0090@0097@0098@0099@0100@0101@0102@0103@0104@0105@0106@0107@0108@0109@0110@0111@0112@0113@0114@0115@0116@0117@0118@0119@0120@0121@0122@"
  def self.latinLetters
    @@latinLetters
  end
  def self.latinLetters=(latinLetters)
    @@latinLetters=latinLetters
  end
  @@greekLetters = "@0913@0914@0935@0916@0917@0934@0915@0919@0921@0977@0922@0923@0924@0925@0927@0928@0920@0929@0931@0932@0933@0962@0937@0926@0936@0918@0945@0946@0967@0948@0949@0966@0947@0951@0953@0966@0954@0955@0956@0957@0959@0960@0952@0961@0963@0964@0965@0982@0969@0958@0968@0950@"
  def self.greekLetters
    @@greekLetters
  end
  def self.greekLetters=(greekLetters)
    @@greekLetters=greekLetters
  end
  def self.latin2Greek(l)
    index = -1
    if l<100
      index = WCharacterBase::latinLetters::indexOf(("@00"+l.to_s)+"@")
    else 
      if l<1000
        index = WCharacterBase::latinLetters::indexOf(("@0"+l.to_s)+"@")
      else 
        index = WCharacterBase::latinLetters::indexOf(("@"+l.to_s)+"@")
      end
    end
    if index!=-1
      s = Std::substr(WCharacterBase::greekLetters,index+1,4)
      return Std::parseInt(s)
    end
    return l
  end
  def self.greek2Latin(g)
    index = -1
    if g<100
      index = WCharacterBase::greekLetters::indexOf(("@00"+g.to_s)+"@")
    else 
      if g<1000
        index = WCharacterBase::greekLetters::indexOf(("@0"+g.to_s)+"@")
      else 
        index = WCharacterBase::greekLetters::indexOf(("@"+g.to_s)+"@")
      end
    end
    if index!=-1
      s = Std::substr(WCharacterBase::latinLetters,index+1,4)
      return Std::parseInt(s)
    end
    return g
  end
  def self.isOp(c)
    return (((((isLarge(c)||isVeryLarge(c))||isBinaryOp(c))||isRelation(c))||(c==Std::charCodeAt(".",0)))||(c==Std::charCodeAt(",",0)))||(c==Std::charCodeAt(":",0))
  end
  def self.isTallAccent(c)
    i = 0
    while i<WCharacterBase::tallAccents::length
      if c==WCharacterBase::tallAccents[i]
        return true
      end
      i+=1
    end
    return false
  end
  def self.isDisplayedWithStix(c)
    if (c>=592)&&(c<=687)
      return true
    end
    if (c>=688)&&(c<=767)
      return true
    end
    if ((c>=8215)&&(c<=8233))||((c>=8241)&&(c<=8303))
      return true
    end
    if (c>=8304)&&(c<=8351)
      return true
    end
    if (c>=8352)&&(c<=8399)
      return true
    end
    if (c>=8400)&&(c<=8447)
      return true
    end
    if (c>=8448)&&(c<=8527)
      return true
    end
    if (c>=8528)&&(c<=8591)
      return true
    end
    if (c>=8592)&&(c<=8703)
      return true
    end
    if (c>=8704)&&(c<=8959)
      return true
    end
    if (c>=8960)&&(c<=9215)
      return true
    end
    if (c>=9312)&&(c<=9471)
      return true
    end
    if (c>=9472)&&(c<=9599)
      return true
    end
    if (c>=9600)&&(c<=9631)
      return true
    end
    if (c>=9632)&&(c<=9727)
      return true
    end
    if (c>=9728)&&(c<=9983)
      return true
    end
    if (c>=9984)&&(c<=10175)
      return true
    end
    if (c>=10176)&&(c<=10223)
      return true
    end
    if (c>=10224)&&(c<=10239)
      return true
    end
    if (c>=10240)&&(c<=10495)
      return true
    end
    if (c>=10496)&&(c<=10623)
      return true
    end
    if (c>=10624)&&(c<=10751)
      return true
    end
    if (c>=10752)&&(c<=11007)
      return true
    end
    if (c>=11008)&&(c<=11263)
      return true
    end
    if (c>=12288)&&(c<=12351)
      return true
    end
    if (c>=57344)&&(c<=65535)
      return true
    end
    if ((c>=119808)&&(c<=119963))||((c>=120224)&&(c<=120831))
      return true
    end
    if ((c==12398)||(c==42791))||(c==42898)
      return true
    end
    return false
  end
end
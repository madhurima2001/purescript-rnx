module View where

import RNX.Events (EventHandler, LayoutEvent, TouchEvent)
import RNX.PropTypes (class AutoEnum, class NoneEnum, Prop, RefType)
import RNX.Styles (Style)
import React (ReactElement, ReactThis, createElement)
import RNX.ComponentClasses (viewClass)
import Unsafe.Coerce (unsafeCoerce)

type ViewProps eff = ViewPropsEx eff () () ()

type ViewPropsEx eff r ra ri = ViewPropsEx' eff (forall props state. ReactThis props state) r ra ri

type ViewPropsEx' eff ref r ra ri =
  { key :: String
  , ref :: RefType ref
  , style :: Style
  , testID :: String
  , accessibilityLabel :: String
  , accessible :: Boolean
  , hitSlop :: {top:: Number, left:: Number, bottom:: Number, right:: Number}
  , onAccessibilityTap :: EventHandler eff TouchEvent
  , onLayout :: EventHandler eff LayoutEvent
  , onMagicTap :: EventHandler eff TouchEvent
  , onMoveShouldSetResponder :: TouchEvent -> Boolean
  , onMoveShouldSetResponderCapture :: TouchEvent -> Boolean
  , onResponderGrant :: EventHandler eff TouchEvent
  , onResponderMove :: EventHandler eff TouchEvent
  , onResponderReject :: EventHandler eff TouchEvent
  , onResponderRelease :: EventHandler eff TouchEvent
  , onResponderTerminate :: EventHandler eff TouchEvent
  , onResponderTerminationRequest :: TouchEvent -> Boolean
  , onStartShouldSetResponder :: TouchEvent -> Boolean
  , onStartShouldSetResponderCapture :: TouchEvent -> Boolean
  , pointerEvents :: PointerEvents
  , removeClippedSubviews :: Boolean
  , android :: Prop
                 { accessibilityComponentType :: AccessibilityType
                 , accessibilityLiveRegion :: AccessibilityLiveRegion
                 , collapsable :: Boolean
                 , importantForAccessibility :: ImportanceForAccessibility
                 , needsOffscreenAlphaCompositing :: Boolean
                 , renderToHardwareTextureAndroid :: Boolean
                 | ra
                 }
  , ios :: Prop
             { accessibilityTraits :: AccessibilityTraits
             , shouldRasterizeIOS :: Boolean
             | ri
             }
  | r
}

newtype PointerEvents = PointerEvents String

newtype AccessibilityType = AccessibilityType String

newtype AccessibilityLiveRegion = AccessibilityLiveRegion String

newtype ImportanceForAccessibility = ImportanceForAccessibility String

newtype AccessibilityTraits = Trait String

instance alrNone :: NoneEnum AccessibilityLiveRegion where
  none = AccessibilityLiveRegion "none"

instance atNone :: NoneEnum AccessibilityType where
  none = AccessibilityType "none"

instance atraitNone :: NoneEnum AccessibilityTraits where
  none = Trait "none"

importanceForAccessibility ::
  { auto :: ImportanceForAccessibility
  , yes :: ImportanceForAccessibility
  , no :: ImportanceForAccessibility
  , noHideDescendants :: ImportanceForAccessibility
  }
importanceForAccessibility =
  { auto: ImportanceForAccessibility "auto"
  , yes: ImportanceForAccessibility "yes"
  , no: ImportanceForAccessibility "no"
  , noHideDescendants: ImportanceForAccessibility "no-hide-descendants"
  }

accessibiltyLiveRegion ::
  { none :: AccessibilityLiveRegion
  , polite :: AccessibilityLiveRegion
  , assertive :: AccessibilityLiveRegion
  }
accessibiltyLiveRegion =
  { none: AccessibilityLiveRegion "none"
  , polite: AccessibilityLiveRegion "polite"
  , assertive: AccessibilityLiveRegion "assertive"
  }

accessibiltyType ::
  { none :: AccessibilityType
  , button :: AccessibilityType
  , radiobutton_checked :: AccessibilityType
  , radiobutton_unchecked :: AccessibilityType
  }
accessibiltyType =
  { none: AccessibilityType "none"
  , button: AccessibilityType "button"
  , radiobutton_checked: AccessibilityType "radiobutton_checked"
  , radiobutton_unchecked: AccessibilityType "radiobutton_unchecked"
  }

accessibilityTraits ::
  { none :: AccessibilityTraits
  , button :: AccessibilityTraits
  , link :: AccessibilityTraits
  , header :: AccessibilityTraits
  , search :: AccessibilityTraits
  , image :: AccessibilityTraits
  , selected :: AccessibilityTraits
  , plays :: AccessibilityTraits
  , key :: AccessibilityTraits
  , text :: AccessibilityTraits
  , summary :: AccessibilityTraits
  , disabled :: AccessibilityTraits
  , frequentUpdates :: AccessibilityTraits
  , startsMedia :: AccessibilityTraits
  , adjustable :: AccessibilityTraits
  , allowsDirectInteraction :: AccessibilityTraits
  , pageTurn :: AccessibilityTraits
  }
accessibilityTraits =
  { none: Trait "none"
  , button: Trait "button"
  , link: Trait "link"
  , header: Trait "header"
  , search: Trait "search"
  , image: Trait "image"
  , selected: Trait "selected"
  , plays: Trait "plays"
  , key: Trait "key"
  , text: Trait "text"
  , summary: Trait "summary"
  , disabled: Trait "disabled"
  , frequentUpdates: Trait "frequentUpdates"
  , startsMedia: Trait "startsMedia"
  , adjustable: Trait "adjustable"
  , allowsDirectInteraction: Trait "allowsDirectInteraction"
  , pageTurn: Trait "pageTurn"
  }

-- need to discuss
traits :: Array AccessibilityTraits -> AccessibilityTraits
traits = unsafeCoerce

boxNone :: PointerEvents
boxNone = PointerEvents "box-none"

instance autoPE :: AutoEnum PointerEvents where
  auto = PointerEvents "auto"

none :: PointerEvents
none = PointerEvents "none"

boxOnly :: PointerEvents
boxOnly = PointerEvents "box-only"


view' :: forall eff. Prop (ViewProps eff) -> Array (ReactElement) -> ReactElement
view' = createElement viewClass

import * as React from "react";
import { Image } from "expo-image";
import { useNavigation, Link, useRouter } from 'expo-router';
import { StyleSheet, Text, View, Pressable } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { Padding, Border, FontSize, Color, FontFamily } from "@/globals/Styles";
import TranslateCmp from "@/services/Translate"
import { TouchableOpacity } from "react-native-gesture-handler";
export {
  // Catch any errors thrown by the Layout component.
  ErrorBoundary,
} from 'expo-router';

const Welcome = () => {
  // Prevent the splash screen from auto-hiding before asset loading is complete.
  const router = useRouter();
  const navigation = useNavigation();

  React.useEffect(() => {
    navigation.setOptions({ headerShown: false, title: "" });
  }, [navigation]);

  return (
    <View style={styles.lightWelcomeScreen}>
      <Image
        style={[styles.gradiantIcon, styles.iconLayout]}
        contentFit="cover"
        source={require("@/assets/gradiant.png")}
      />

      <LinearGradient
        style={[styles.typebuttonType2primaryT, styles.typebuttonPosition]}
        locations={[0, 1]}
        colors={["#7e92f8", "#6972f0"]
        }
      >
        <TouchableOpacity style={[styles.pressable, styles.pressableFlexBox]} onPress={() => { router.replace('./SignIn') }}>
          <Text style={[styles.logIn, styles.logInTypo]}>{TranslateCmp("login")}</Text>
        </TouchableOpacity>
      </LinearGradient>
      <TouchableOpacity style={[styles.typebuttonType2secondary, styles.pressableFlexBox]} onPress={() => { router.replace('./SignUp') }} >
        <Text style={[styles.signUp, styles.logInTypo]}>{TranslateCmp("signup")}</Text>
      </TouchableOpacity>
      <View
        style={[
          styles.elementsorContinueWithDar,
          styles.autoLayoutHorizontalLayout,
        ]}
      >
        <Image
          style={[styles.darkfalseComponentdividerIcon, styles.iconLayout]}
          contentFit="cover"
          source={require("@/assets/line.png")}
        />
        <Text style={[styles.or, styles.orLayout]}>{TranslateCmp("orcontinuewith")}</Text>
        <Image
          style={[styles.darkfalseComponentdividerIcon1, styles.iconLayout]}
          contentFit="cover"
          source={require("@/assets/line.png")}
        />
      </View>
      <View
        style={[styles.autoLayoutHorizontal, styles.autoLayoutHorizontalLayout]}
      >
        <View style={styles.typeloginBorder}>
          <View style={[styles.autoLayoutHorizontal1, styles.prodigiesFlexBox]}>
            <Image
              style={[styles.frameIcon, styles.frameIconLayout]}
              contentFit="cover"
              source={require("@/assets/google.png")}
            />
            <Text style={[styles.continueWithGoogle, styles.textTypo]}>
              Continue with Google
            </Text>
          </View>
        </View>
        <View style={[styles.typeloginType2socialTyp1, styles.typeloginBorder]}>
          <View style={[styles.autoLayoutHorizontal1, styles.prodigiesFlexBox]}>
            <Image
              style={[styles.frameIcon1, styles.frameIconLayout]}
              contentFit="cover"
              source={require("@/assets/apple.png")}
            />
            <Text style={[styles.continueWithGoogle, styles.textTypo]}>
              Continue with Apple
            </Text>
          </View>
        </View>
        <View style={[styles.typeloginType2socialTyp1, styles.typeloginBorder]}>
          <View style={[styles.autoLayoutHorizontal1, styles.prodigiesFlexBox]}>
            <Image
              style={[styles.frameIcon1, styles.frameIconLayout]}
              contentFit="cover"
              source={require("@/assets/meta.png")}
            />
            <Text style={[styles.continueWithGoogle, styles.textTypo]}>
              Continue with Facebook
            </Text>
          </View>
        </View>
      </View>
      <View style={styles.frameParent}>
        <View style={[styles.prodigiesParent, styles.prodigiesParentPosition]}>
          <Text style={[styles.prodigies, styles.prodigiesFlexBox]}>
            Prodigies
          </Text>
          <Text style={[styles.version10, styles.orLayout]}>AI Assistants</Text>
        </View>
        <Image
          style={styles.httpslottiefilescomanimatIcon}
          contentFit="cover"
          source={require("@/assets/splashAnimation.png")}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  iconLayout: {
    maxHeight: "100%",
    maxWidth: "100%",
    overflow: "hidden",
  },
  typebuttonPosition: {
    width: 350,
    left: 19,
    position: "absolute",
  },
  pressableFlexBox: {
    paddingVertical: Padding.p_lg,
    paddingHorizontal: Padding.p_base,
    borderRadius: Border.br_81xl,
    justifyContent: "center",
    alignItems: "center",
    flexDirection: "row",
  },
  logInTypo: {
    textAlign: "center",
    fontFamily: 'Urbanist-SemiBold',
    fontSize: FontSize.h4Bold_size,
    fontWeight: "bold",
  },

  autoLayoutHorizontalLayout: {
    width: 340,
    flexDirection: "row",
    position: "absolute",
  },
  orLayout: {
    lineHeight: 29,
    fontSize: FontSize.bodyXlargeSemibold_size,
  },
  prodigiesFlexBox: {
    justifyContent: "center",
    alignItems: "center",
  },
  frameIconLayout: {
    height: 24,
    overflow: "hidden",
  },
  textTypo: {
    textAlign: "left",
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "600",
    letterSpacing: 0,
  },
  typeloginBorder: {
    paddingHorizontal: Padding.p_13xl,
    borderWidth: 1,
    borderColor: Color.colorWhitesmoke,
    borderStyle: "solid",
    paddingVertical: Padding.p_lg,
    justifyContent: "center",
    alignItems: "center",
    borderRadius: Border.br_81xl,
    flex: 1,
    backgroundColor: Color.white,
  },
  prodigiesParentPosition: {
    left: 0,
    position: "absolute",
  },
  gradiantIcon: {
    height: "124.14%",
    width: "275.58%",
    top: "-12.02%",
    right: "-87.67%",
    bottom: "-12.12%",
    left: "-87.91%",
    position: "absolute",
  },
  logIn: {
    textAlign: "center",
    color: Color.white,
  },
  pressable: {
    // shadowColor: "rgba(116, 131, 244, 0.1)",
    // shadowRadius: 24,
    elevation: 24,
    // shadowOpacity: 1,
    backgroundColor: 'transparent',
    width: "100%",
  },
  typebuttonType2primaryT: {
    top: 453,
    borderRadius: 100,
  },
  signUp: {
    color: Color.primaryColor,
    fontFamily: FontFamily.bodyLargeSemibold,
    fontSize: FontSize.h5Bold_size,
  },
  typebuttonType2secondary: {
    top: 541,
    width: 350,
    left: 19,
    position: "absolute",
    backgroundColor: Color.white,
  },
  darkfalseComponentdividerIcon: {
    flex: 1,
    height: 2
  },
  or: {
    fontWeight: "500",
    fontFamily: 'Urbanist-SemiBold',
    marginLeft: 16,
    textAlign: "center",
    color: Color.purple,
  },
  darkfalseComponentdividerIcon1: {
    height: 2,
    marginLeft: 16,
    flex: 1,
  },
  elementsorContinueWithDar: {
    bottom: 120,
    justifyContent: "center",
    alignItems: "center",
    left: 25,
    right: 25,
  },

  frameIcon: {
    width: 24,
  },
  continueWithGoogle: {
    color: Color.greyscale900,
    display: "none",
    marginLeft: 12,
    lineHeight: 29,
    fontSize: FontSize.bodyXlargeSemibold_size,
  },
  autoLayoutHorizontal1: {
    flexDirection: "row",
    alignItems: "center",
  },
  frameIcon1: {
    width: 24,
  },
  typeloginType2socialTyp1: {
    marginLeft: 16,
  },
  autoLayoutHorizontal: {
    bottom: 35,
    left: 25,
  },

  prodigies: {
    color: "#6972F0",
    fontSize: 64,
    lineHeight: 102,
    fontFamily: 'RoadRage-Regular',
    display: "flex",
    height: 89,
    width: 290,
    textAlign: "center",
  },
  version10: {
    fontFamily: 'Urbanist-Regular',
    color: "#555",
    textAlign: "center",
  },
  prodigiesParent: {
    top: 128,
    alignItems: "flex-end",
  },
  httpslottiefilescomanimatIcon: {
    left: 75,
    width: 128,
    height: 128,
    top: 0,
    position: "absolute",
    overflow: "hidden",
    fontFamily: 'RoadRage-Regular',
  },
  frameParent: {
    top: 175,
    left: 50,
    height: 206,
    width: 210,
    position: "absolute",
  },
  lightWelcomeScreen: {
    height: 852,
    overflow: "hidden",
    width: "100%",
    flex: 1,
    backgroundColor: Color.white,
  },
});

export default Welcome;

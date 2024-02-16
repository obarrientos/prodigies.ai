import * as React from "react";
import { Image } from "expo-image";
import { StyleSheet, Text, View } from "react-native";
import { FontFamily, FontSize, Color, Padding, Border } from "../globals/Styles";
import { Meta } from '@/services/Meta';
import { Google } from '@/services/Google';
import { TouchableOpacity } from "react-native-gesture-handler";
import TranslateCmp from "@/services/Translate"
const SocialNetwork = () => {
  return (
    <View style={styles.socialLoginSection}>
      <View style={styles.orContinueTitle} >
        <Image
          style={styles.lineLayout}
          contentFit="cover"
          source={require("@/assets/line.png")}
        />
        <Text style={styles.orContinueWithText}>{TranslateCmp("orcontinuewith")}</Text>
        <Image
          style={styles.lineLayout}
          contentFit="cover"
          source={require("@/assets/line.png")}
        />
      </View>
      <View style={styles.socialNetsSection}>
        <TouchableOpacity style={styles.SocialButtons} onPress={() => Google()}>
          <View style={styles.socialIconSection}>

            <View style={styles.networkIcon}>
              <Image
                style={styles.frameIcon}
                contentFit="cover"
                source={require("@/assets/google.png")}
              />
              <Text style={styles.continueWithSocialIcon}>
                Continue with Google
              </Text>
            </View>

          </View>
        </TouchableOpacity>
        <TouchableOpacity style={styles.SocialButtons} onPress={() => Meta()}>
        <View
          style={styles.socialIconSection}
        >
          <View style={styles.networkIcon}>
            <Image
              style={[styles.frameIcon, styles.iconLayout]}
              contentFit="cover"
              source={require("@/assets/apple.png")}
            />
            <Text style={styles.continueWithSocialIcon}>
              Continue with Apple
            </Text>
          </View>
        </View>
        </TouchableOpacity>
        <TouchableOpacity style={styles.SocialButtons} onPress={() => Meta()}>
        <View
          style={styles.socialIconSection}
        >
          
            <View style={styles.networkIcon}>
              <Image
                style={[styles.frameIcon, styles.iconLayout]}
                contentFit="cover"
                source={require("@/assets/meta.png")}
              />
              <Text style={styles.continueWithSocialIcon}>
                Continue with Facebook
              </Text>
            </View>
          
        </View>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  orContinueTitle: {
    justifyContent: "center",
    alignItems: "center",
    flexDirection: "row",
  },

  orContinueWithText: {
    fontWeight: "500",
    fontFamily: 'Urbanist-SemiBold',
    color: "#6357FF",
    fontSize: FontSize.bodyXlargeBold_size,
  },

  socialLoginSection: {
    top: 75,
  },
  
  socialNetsSection: {
    flexDirection: "row",
    alignContent:"center",
  },

  SocialButtons: {  
    top: 10,
    marginLeft: 22,
    height:40,
  },

  socialIconSection: {
    paddingVertical: Padding.p_lg,
    paddingHorizontal: Padding.p_13xl,
    borderWidth: 1,
    borderRadius: Border.br_81xl,
    borderColor: Color.colorWhitesmoke_200,
    borderStyle: "solid",
    alignItems: "center",
    justifyContent: "center",
    flex: 1,
    backgroundColor: Color.othersWhite,

  },

  continueWithSocialIcon: {
    marginLeft: 12,
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "600",
    letterSpacing: 0,
    textAlign: "left",
    display: "none",
    color: Color.greyscale900,
    lineHeight: 29,
    fontSize: FontSize.bodyXlargeBold_size,
  },
  networkIcon: {
    alignItems: "center",
    flexDirection: "row",
    justifyContent: "center",
  },

  frameIcon: {
    width: 23,
    height: 24,
    overflow: "hidden",
  },
  lineLayout: {
    flex: 1,
    height: 2,
    marginLeft:15,
    marginRight:15,
  },
  iconLayout: {
    width: 24,
    height: 24,
  },

});

export default SocialNetwork;

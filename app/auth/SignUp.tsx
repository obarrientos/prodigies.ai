import React, { useState, useEffect } from 'react';
import { StyleSheet, Pressable, Text, View } from "react-native";
import { Color, FontSize, Padding } from "@/globals/Styles";
import { Link, useNavigation } from 'expo-router';
import ConnectSocial from "@/components/SocialNetwork";
import ButtonActionCmp from "@/components/Button";
import TextInputCmp from "@/components/TextField";
import PwdInputCmp from "@/components/Password";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { useRouter } from 'expo-router';
import { auth } from '@/services/Firebase';
import Checkbox from 'expo-checkbox';
import SignedUpSuccessfully from "@/auth/modals/SignedUp"
import TranslateCmp from "@/services/Translate"



const SignUp = () => {

  const navigation = useNavigation();
  const router = useRouter();
  const [usernameValue, setUserValue] = useState('');
  const [passwordValue, setPasswordValue] = useState('');
  const [modalVisible, setModalVisible] = useState(false); // State to control modal visibility
  const [errorCodeValue, setErrorCodeValue] = useState('');
  const [isChecked, setChecked] = useState(false);

  React.useEffect(() => {
    navigation.setOptions({ headerShown: true, title: TranslateCmp("signup"), headerBackVisible: false, });
  }, [navigation]);

  const handleSubmit = () => {

    createUserWithEmailAndPassword(auth, usernameValue, passwordValue)
      .then((userCredential) => {
        console.log(userCredential);
        setModalVisible(true);
        // Wait for 3 seconds before navigating
        setTimeout(() => {
          setModalVisible(false); // Close the modal just before navigating
          router.replace('../screens/Index'); // Adjust with your actual navigation call
        }, 2000);

      })
      .catch((error) => {
        if(error.code === "auth/invalid-email"){
          setErrorCodeValue("Invalid Email");
        }
              })
    setModalVisible(false);
  };
 
  
  return (
    <View style={styles.container}>

      <Text style={styles.Title}> {TranslateCmp("hellothere")} </Text>
      <Text style={styles.SubTitle}>{TranslateCmp("pleaseentercredentials")}</Text>

      <TextInputCmp label={TranslateCmp("email")} value={usernameValue} onChange={setUserValue} result={errorCodeValue} />
      <PwdInputCmp label={TranslateCmp("password")} value={passwordValue} onChange={setPasswordValue}  />

      <View style={styles.line} />

      <View style={styles.iAgreeSection} >
      <Checkbox
          style={styles.checkbox}
          value={isChecked}
          onValueChange={setChecked}
          color={isChecked ? '#4630EB' : undefined}
        />
        <Text style={[styles.iAgreeToContainer, styles.text2Typo1]}>
          <Text style={styles.iAgreeToContainer1}>
            <Text style={styles.iAgreeToProdigiesAi}>
              <Text style={styles.text2Typo}>{TranslateCmp("iagreeto")}</Text>
              <Text style={styles.logInTypo}>Prodigies AI</Text>
            </Text>
            <Text style={styles.text2Typo}>
              <Text style={styles.iAgreeToProdigiesAi}>{` `}</Text>
              <Text
                style={styles.publicAgreementTerms}
              >{TranslateCmp("publicagreement")}</Text>
            </Text>
          </Text>
        </Text>
      </View>

      <View style={styles.forgotPasswordSection} >
        <Pressable style={styles.dontHaveAnAccountPressable} onPress={() => { }}>
          <Text style={styles.dontHaveAnAccountText}>{TranslateCmp("alreadyhaveaccount")}</Text>
          <Link href="./SignIn"><Text style={styles.signUp}>{TranslateCmp("signin")}</Text></Link>
        </Pressable>
      </View>

      <ConnectSocial/>
      <View style={styles.buttonPosition}>
        <ButtonActionCmp label={TranslateCmp("continue")} onPress={handleSubmit} disabled={!isChecked || !usernameValue || !passwordValue} />
      </View>
      <SignedUpSuccessfully modalVisible={modalVisible} setModalVisible={() => setModalVisible(!modalVisible)}/>
    </View>
  );
};

const styles = StyleSheet.create({

  container: {
    flexDirection: 'column', // This is actually the default and can be omitted
    flex: 1, // Optional, for the container to take the full height of the screen
    backgroundColor: Color.othersWhite,
    padding: Padding.p_base
  },

  titleSection: {
    color: Color.greyscale900,
    fontFamily: 'Urbanist-SemiBold',
  },
  Title: {
    fontSize: FontSize.h3Bold_size,
    height: 60,
  },
  SubTitle: {
    fontSize: FontSize.bodyLargeSemibold_size,
    height: 80,
    lineHeight:22,

  },
  forgotPasswordSection: {
    position: "relative",
  },
  dontHaveAnAccountText: {
    lineHeight: 26,
    fontSize: FontSize.bodyLargeSemibold_size,
    letterSpacing: 0,
    textAlign: "center",
    color: Color.greyscale900,
    marginRight: 15,
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "500",
  },
  dontHaveAnAccountPressable: {
    top: 25,
    width: 354,
    alignItems: "center",
    flexDirection: "row",
    justifyContent: "center",
    position: "absolute",
  },
  iconLayout: {
    width: 24,
    height: 24,
  },
  line: {
    height: 1,
    width: "90%",
    borderColor: Color.colorWhitesmoke_200,
    borderTopWidth: 1,
    borderStyle: "solid",
    position: "relative",
  },
  signUp: {
    marginLeft: 8,
    lineHeight: 26,
    fontSize: FontSize.bodyLargeSemibold_size,
    letterSpacing: 0,
    color: Color.primaryDark,
    textAlign: "center",
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "700",
  },

  iAgreeSection: {
    width: "100%",
    top: 10,
    alignItems: "center",
    flexDirection: "row",
  },


  iAgreeToContainer: {
    width: 308,
    marginLeft: 16,
    alignItems: "center",
    display: "flex",
  },
  text2Typo1: {
    lineHeight: 26,
    fontSize: FontSize.bodyLargeSemibold_size,
    letterSpacing: 0,
    textAlign: "left",
  },
  iAgreeToContainer1: {
    width: "100%",
  },
  iAgreeToProdigiesAi: {
    color: Color.greyscale900,
  },

  text2Typo: {
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "600",
  },
  logInTypo: {
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "700",
  },
  publicAgreementTerms: {
    color: Color.primaryDark,
  },
  buttonPosition: {
    width:"100%",
    position: "absolute",
    alignSelf: "center",
    bottom: 20,
  },

  checkbox: {
    margin: 8,
  },
});

export default SignUp;

import React, { useState, useEffect } from 'react';
import { StyleSheet, Pressable, Text, View } from 'react-native';
import { Link, useNavigation } from 'expo-router';
import { getAuth, signInWithEmailAndPassword } from 'firebase/auth';
import ButtonActionCmp from '@/components/Button';
import TextInputCmp from '@/components/TextField';
import PwdInputCmp from '@/components/Password';
import ConnectSocial from '@/components/SocialNetwork';
import { useRouter } from 'expo-router';
import { Color, FontSize, Padding } from "@/globals/Styles";
import Checkbox from 'expo-checkbox';
import SignedUpSuccessfully from "@/auth/modals/SignedUp"
import TranslateCmp from "@/services/Translate"

const SignIn = () => {
   
  const router = useRouter();
  const navigation = useNavigation();

  const [usernameValue, setUsernameValue] = useState('obarrientos@hotmail.com');
  const [passwordValue, setPasswordValue] = useState('Zxcvb123!');
  const [errorMessage, setErrorMessage] = useState('');
  const [modalVisible, setModalVisible] = useState(false); // State to control modal visibility
  const [isChecked, setChecked] = useState(false);

  useEffect(() => {
    navigation.setOptions({ headerShown: true, title: TranslateCmp("signin"),headerBackVisible: false, });
  }, [navigation]);

  const handleSignIn = () => {

    const auth = getAuth();
    
    signInWithEmailAndPassword(auth, usernameValue, passwordValue)
      .then((userCredential) => {
        // Handle successful sign in
        setModalVisible(true);
        setTimeout(() => {
          setModalVisible(false); // Close the modal just before navigating
          //router.replace('../screens/auth/ProfileScreen'); // Adjust with your actual navigation call
        }, 2000);
        router.replace('../screens/Chats');
        // const user = userCredential.user;
      })
      .catch((error) => {
        // Handle errors here
        setErrorMessage(error.message);
        // Hide the error message after 5 seconds
        setTimeout(() => {
          setErrorMessage('');
        }, 5000);        
        // const errorCode = error.code;
        // const errorMessage = error.message;
      });
  };

  return (
    <View style={styles.container}>
      {errorMessage !== '' && (
        <View style={styles.errorBar}>
          <Text style={styles.errorText}>{errorMessage}</Text>
        </View>
      )}
      <Text style={styles.title}>{TranslateCmp("welcome")}</Text>
      <Text style={styles.subTitle}>{TranslateCmp("credentials")}</Text>
      <TextInputCmp label={TranslateCmp("email")} value={usernameValue} onChange={setUsernameValue}/>
      <PwdInputCmp label={TranslateCmp("password")} value={passwordValue} onChange={setPasswordValue} />
      <View style={styles.line} />

      <View style={styles.rememberMeSection} >
      <Checkbox
          style={styles.checkbox}
          value={isChecked}
          onValueChange={setChecked}
          color={isChecked ? '#4630EB' : undefined}
        />
        <Text style={styles.rememberMe}>{TranslateCmp("rememberme")}</Text>
      </View>

      <View style={styles.forgotPasswordSection} >
        <Pressable onPress={() => { }}>
          <Text style={styles.forgotPassword}>{TranslateCmp("forgotpassword")}</Text>
        </Pressable>

        <Pressable style={styles.dontHaveAnAccountPressable} onPress={() => { }}>
          <Text style={styles.dontHaveAnAccountText}>{TranslateCmp("donthaveaccount")}</Text>
          <Link href="./SignUp"><Text style={styles.signUp}>{TranslateCmp("signup")}</Text></Link>
        </Pressable>
      </View>

      <ConnectSocial />
      <View style={styles.buttonPosition}>
        <ButtonActionCmp label={TranslateCmp("login")}  onPress={handleSignIn} disabled={false} />
      </View>
      <SignedUpSuccessfully modalVisible={modalVisible} setModalVisible={() => setModalVisible(!modalVisible)}/>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Color.white,
    padding: Padding.p_base,
  },
  title: {
    fontSize: 22,
    fontWeight: 'bold',
    marginVertical: 8,
  },
  subTitle: {
    fontSize: 18,
    marginVertical: 8,
    marginBottom:40,
  },
  
  forgotPasswordSection: {
    top: 30,
  },
  dontHaveAnAccountText: {
    lineHeight: 26,
    fontSize: FontSize.bodyLargeSemibold_size,
    textAlign: "center",
    color: Color.greyscale900,
    marginRight: 15,
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "500",
  },
  dontHaveAnAccountPressable: {
    top: 20,
    width: 350,
    alignItems: "center",
    flexDirection: "row",
    justifyContent: "center",
    position: "relative",
  },
  iconLayout: {
    width: 24,
    height: 24,
  },


  inputSection: {
    position: "relative",
  },


  rememberMeSection: {
    top:5,
    alignItems: "center",
    flexDirection: "row",
    position: "relative",
   },
  rememberMe: {
    lineHeight: 26,
    fontSize: FontSize.bodyLargeSemibold_size,
    color: Color.greyscale900,
    flex: 1,
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "600",
    letterSpacing: 0,
    textAlign: "left",
  },
  lineLayout: {
    maxHeight: "100%",
    maxWidth: "100%",
    overflow: "hidden",
    flex: 1,
    height: 2,
    left: 15,
  },
  line: {
    height: 1,
    width: "90%",
    borderColor: Color.colorWhitesmoke_200,
    borderTopWidth: 1,
    borderStyle: "solid",
    position: "relative",
  },
  forgotPassword: {
    color: Color.primaryDark,
    textAlign: "center",
    fontFamily: 'Urbanist-SemiBold',
    fontWeight: "700",
    lineHeight: 29,
    fontSize: FontSize.bodyXlargeBold_size,
    width: 354,
    justifyContent: "center",
    display: "flex",
    alignItems: "center",
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
  frameIcon: {
    width: 23,
    height: 24,
    overflow: "hidden",
  },
  iconlyregularboldmessage: {
    top: 16,
    left: 280,
    width: 33,
    height: 28,
    position: "absolute",
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

  errorBar: {
    position: 'relative',
    top: 0,
    left: 0,
    right: 0,
    backgroundColor: 'red',
    padding: 10,
  },
  errorText: {
    color: 'white',
    textAlign: 'center',
    fontWeight: 'bold',
  },
});

export default SignIn;

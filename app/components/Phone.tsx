import * as React from "react";
import { StyleSheet, View, Text, TextInput } from "react-native";
import { useNavigation } from 'expo-router';
import { Border, FontSize, Color } from "@/globals/Styles";
import { Image } from "expo-image";
import { useColorScheme } from 'react-native';
const Phone = ({ label = "", value, onChange }) => {



  const navigation = useNavigation();


  let colorScheme = useColorScheme();

  if (colorScheme === 'dark') {
    // render some dark thing
  } else {
    // render some light thing
  }


  // ******** PHONE ***********//  


    return (

      <View style={styles.container}>
        <Text style={styles.label}>{label}</Text>
          <View style={styles.frame} >
          <TextInput
            // secureTextEntry={true}
            style={styles.inputText}
            placeholder={label}
            placeholderTextColor={Color.greyscale500}
            value={value}
            onChangeText={onChange}
          />
          <Image
            style={styles.icon}
            contentFit="cover"
            source={require("@/assets/phone1.png")}
          />
        </View>
       </View>
    )


};


const styles = StyleSheet.create({

  container: {
    marginTop:2,
    marginBottom:2,
    // flexDirection: 'column', // Explicitly setting the flex direction
    // justifyContent: 'center', // Adjust this for vertical alignment
    // alignItems: 'center', // Adjust this for horizontal alignment within each item   
    // borderWidth: 1,
    height:110,
  },

  label: {
    bottom: 10,
    fontSize: FontSize.bodyLargeSemibold_size,
    color: Color.greyscale900,
    fontFamily: 'Urbanist-SemiBold',
  },

  frame: {
    alignSelf: "center",
    height: 60,
    width: 345,
    borderRadius: Border.br_31xl,
    borderWidth: 1,
    backgroundColor: Color.colorWhitesmoke_100,
  },

  inputText: {
    left: 20,
    fontSize: FontSize.size_xl,
    top: 18,
    width: 250,
    fontFamily: 'Urbanist-SemiBold',
    
  },
   
    icon: {
      top: 16,
      left: 290,
      width: 26,
      height: 26,
      position: "absolute",
    },

});

export default Phone
;

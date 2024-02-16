import * as React from "react";
import { StyleSheet, View, Text, TouchableOpacity } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { Link, useNavigation } from 'expo-router';
import { Padding, Border, FontSize, Color } from "@/globals/Styles";
const Button = ({ label = "", onPress, disabled }) => {
  const navigation = useNavigation();

  // Decide button style based on `disabled` state
  const buttonStyle = disabled
    ? [styles.button, styles.buttonDisabled] // Use spread operator to combine styles
    : styles.button;

  return (

    <View style={styles.container}>

      <TouchableOpacity onPress={onPress} style={buttonStyle} disabled={disabled}>
        <Text style={styles.TextStyle}>{label}</Text>
      </TouchableOpacity>

    </View>

  );
};

const styles = StyleSheet.create({

  container: {
    flex: 1,
    alignSelf: "center",
    width: "95%",
  },

  button: {
    width: "100%",
    borderRadius: 100,
    position: "relative",
    height: 60,
    backgroundColor: "#7e92f8",

  },
  buttonDisabled: {
    backgroundColor: "#cccccc", // Different background color when disabled
    // You can also adjust other styles like opacity: 0.5 if you prefer
  },

  TextStyle: {
    textAlign: "center",
    color: Color.white,
    fontWeight: "700",
    letterSpacing: 0,
    lineHeight: 60,
    fontSize: FontSize.bodyXlargeSemibold_size,
    flex: 1,
  },

});

export default Button;

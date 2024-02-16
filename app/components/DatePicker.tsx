import * as React from "react";
import { StyleSheet, View, Text, Pressable, TextInput, Image,Platform } from "react-native";
import DateTimePicker from '@react-native-community/datetimepicker';
import { useColorScheme } from 'react-native';
import { Border, FontSize, Color } from "@/globals/Styles";

const DatePicker = ({ label = "", value, onChange }) => {
  const colorScheme = useColorScheme();
  const [date, setDate] = React.useState(value || new Date());
  const [show, setShow] = React.useState(false);

  // const handleChange = (event, selectedDate) => {
  //   if(Platform.OS === "android"){

  //     const currentDate = selectedDate;
  //     setDate(currentDate.toDateString());
  //   }else{

  //     const currentDate = selectedDate;
  //     setDate(currentDate);
  //   }
  // };

  const handleChange = (event, selectedDate) => {
    const currentDate = selectedDate || date; // Fallback to the current date if no date is selected
    setShow(Platform.OS === 'ios'); // For iOS, keep the picker open until manual close
    setDate(currentDate); // Always store the date as a Date object
  };

  const onConfirm = () => {
    setShow(false);
    onChange(date); // Pass the current date state back to the parent component
  };

  const onCancel = () => {
    setShow(false);
  };

  const showDatePicker = () => {
    setShow(true);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.label}>{label}</Text>
      {!show && (
        <View style={styles.frame}>

          <Pressable style={styles.showDatePicker} onPress={showDatePicker}>
       
            <Text style={styles.inputText}>
              {date.toLocaleDateString()} {/* Display date in a readable format */}
            </Text>
              <Image
                style={styles.icon}
                source={require("@/assets/calendar.png")} // Ensure this path is correct
              />
          </Pressable>
        </View>
      )}
      {show && (
        <View>
          <DateTimePicker
            testID="dateTimePicker"
            value={date}
            mode="date"
            display="spinner"
            maximumDate={new Date()}
            onChange={handleChange} // Now properly handles date selection
          />
          { show && Platform.OS === "ios" && (
          <View style={styles.buttons}>
            <Pressable style={styles.buttonCancel} onPress={onCancel}>
              <Text style={styles.buttonText}>Cancel</Text>
            </Pressable>
            <Pressable style={styles.buttonConfirm} onPress={onConfirm}>
              <Text style={styles.buttonText}>Confirm</Text>
            </Pressable>
          </View>
          )}
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginTop: 2,
    marginBottom: 2,
  },
  label: {
    fontSize: FontSize.bodyLargeSemibold_size,
    color: Color.greyscale900,
    fontFamily: 'Urbanist-SemiBold',
    marginBottom: 10,
  },
  frame: {
    alignSelf: "center",
    height: 60,
    width: 345,
    borderRadius: Border.br_31xl,
    borderWidth: 1,
    backgroundColor: Color.colorWhitesmoke_100,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
  },
  inputText: {
    fontSize: FontSize.size_xl,
    fontFamily: 'Urbanist-SemiBold',
    width:265,
  },
  icon: {
    width: 26,
    height: 26,
  },
  showDatePicker: {
    // Additional styles if necessary
    flexDirection: 'row',
    // borderWidth:1,

  },

  buttons:{
    flex:1,
    flexDirection: 'row',
    alignItems:"center",
    alignSelf:"center",
  },

  buttonCancel: {
    // backgroundColor: "green",
    borderColor: Color.greyscale500,
    margin:5,
    borderRadius: 20,
    borderWidth: 1,
    alignItems: "center",
    width: 100,
  },
  buttonConfirm: {
    margin:5,
    borderColor: Color.greyscale500,
    borderRadius: 20,
    borderWidth: 1,
    alignItems: "center",
    width: 100,  
  },

  buttonText: {
    lineHeight: 40,
    flex: 1,
    color: Color.primaryColor,

  }
});

export default DatePicker;

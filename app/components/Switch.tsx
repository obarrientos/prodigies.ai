import React, { useEffect, useState } from 'react';
import { StyleSheet, View, Text, Switch } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { Link, useNavigation } from 'expo-router';
import { Padding, Border, FontSize, Color } from "@/globals/Styles";
const Boolean = ({ label = "", onPress = () => {}, disabled = false}) => {
    const [isEnabled, setIsEnabled] = useState(false);
    const toggleSwitch = () => setIsEnabled(previousState => !previousState);
    const navigation = useNavigation();

    return (

        <View style={styles.container}>

            <Switch
                trackColor={{ false: '#767577', true: '#81b0ff' }}
                thumbColor={isEnabled ? Color.primaryColor : '#f4f3f4'}
                ios_backgroundColor="#3e3e3e"
                onValueChange={toggleSwitch}
                value={isEnabled}
                style={styles.switch} />
        </View>

    );
};

const styles = StyleSheet.create({

    container: {
        flex: 1,
        alignSelf: "center",
        width: "95%",
    },
    switch: {
        width: 60,
        height: 30,
    }
});

export default Boolean;

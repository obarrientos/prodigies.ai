import React, { useState } from 'react';
import { StyleSheet, View, Text, Switch } from "react-native";
import { Color } from "@/globals/Styles";
const Boolean = ({ onPress = () => { } }) => {
    const [isEnabled, setIsEnabled] = useState(false);
    const toggleSwitch = () => setIsEnabled(previousState => !previousState);
    return (

        <Switch
            trackColor={{ false: Color.colorWhitesmoke_100, true: Color.primaryColor }}
            thumbColor={isEnabled ? Color.colorWhitesmoke_100 : Color.colorWhitesmoke_100}
            ios_backgroundColor={Color.colorWhitesmoke_100}
            onValueChange={toggleSwitch}
            value={isEnabled}
            style={styles.switch}
        />

    );
};

const styles = StyleSheet.create({


    switch: {
        width: 50,
        height: 30,
    }
});

export default Boolean;
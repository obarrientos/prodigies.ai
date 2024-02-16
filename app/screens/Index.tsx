import React, { useState, useEffect } from 'react';
import { ScrollView, View, Text, Image, StyleSheet, TouchableOpacity, Animated } from 'react-native';
import TranslateCmp from "@/services/Translate";
import { useNavigation, useRouter } from 'expo-router';
import { FontFamily, FontSize, Color, Padding, Border } from "@/globals/Styles";
import { Products } from '@/globals/Products';
import FlatListMenu from '@/components/FlatListMenu';
import NavigationBar from '@/components/NavigationBar';
import { AntDesign } from '@expo/vector-icons'; // Importing AntDesign icon library

const navigateToContent = contentPath => console.log(`Navigating to ${contentPath}`);

const Index = () => {
    const router = useRouter();
    const navigation = useNavigation();
    const [opacity] = useState(new Animated.Value(0));
    const [selectedCategory, setSelectedCategory] = useState('All');
    const [filteredProducts, setFilteredProducts] = useState([]);
    const [activeButton, setActiveButton] = useState('aiAssistants');

    useEffect(() => {
        if (selectedCategory === 'All') {
            setFilteredProducts(Products);
        } else {
            const filtered = Products.filter(category => category.category === selectedCategory);
            setFilteredProducts(filtered);
        }
    }, [selectedCategory]);

    useEffect(() => {
        Animated.timing(opacity, {
            toValue: 1,
            duration: 500,
            useNativeDriver: true,
        }).start();
    }, [opacity]);

    useEffect(() => {
        navigation.setOptions({
            headerShown: true,
            title: TranslateCmp("AIAssistants"),
            headerBackVisible: false,
            headerRight: () => (
                <TouchableOpacity
                    style={styles.settingsButton}
                    onPress={() => router.replace('../screens/Menu')}
                >
                    <AntDesign name="setting" size={24} color={Color.primaryColor} />
                </TouchableOpacity>
            ),
            headerLeft: () => (
                <TouchableOpacity
                    style={styles.settingsButton}
                    onPress={() => router.replace('../screens/Menu')}
                >
                    <AntDesign name="setting" size={24} color={Color.primaryColor} />
                </TouchableOpacity>
            ),
        });
    }, [navigation]);  

    const handlePress = (buttonName) => {
        Animated.timing(opacity, {
            toValue: 0,
            duration: 500,
            useNativeDriver: true,
        }).start(() => {
            if (buttonName === 'chats') {
                setActiveButton('chats');
                router.replace('../screens/Index');
            } else {
                setActiveButton('aiAssistants');
                router.replace('../screens/Chats');
            }
        });        
    };
        
    return (
        <>
            <FlatListMenu categories={Products} selected={setSelectedCategory} />
            <ScrollView style={styles.container}>
                {filteredProducts.map((category, categoryIndex) => (
                    <View key={categoryIndex} style={styles.categoryContainer}>
                        <Text style={styles.headerTitle}>{category.category}</Text>
                        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
                            {category.items.map((product, productIndex) => (
                                <TouchableOpacity key={productIndex} style={styles.productButton} onPress={() => navigateToContent(product.onPressPath)}>
                                    <Image style={styles.productImage} source={product.image} />
                                    <Text numberOfLines={2} ellipsizeMode="tail" style={styles.productName}>{product.name}</Text>
                                    <Text numberOfLines={2} ellipsizeMode="tail" style={styles.productDescription}>{product.description}</Text>
                                </TouchableOpacity>
                            ))}
                        </ScrollView>
                    </View>
                ))}
            </ScrollView>
            <NavigationBar selected={() => handlePress(activeButton)} screen={activeButton}/>
        </>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: Color.othersWhite,
        paddingLeft: Padding.p_base,
    },
    categoryContainer: {
        paddingTop: Padding.p_5xs,
        paddingBottom: Padding.p_5xs,
    },
    headerTitle: {
        fontSize: FontSize.h5Bold_size,
        fontFamily: FontFamily.h4Bold,
        paddingBottom: Padding.p_3xs,
    },
    productButton: {
        marginRight: Padding.p_base,
        marginTop: Padding.p_3xs,
        padding: Padding.p_5xs,
        paddingTop: Padding.p_xs,
        alignItems:"center",
        width: 173,
        backgroundColor: Color.colorWhitesmoke_200,
        borderRadius: Border.br_base,
    },
    productImage: {
        width: 56,
        height: 56,
        borderRadius: Border.br_81xl,
    },
    productName: {
        fontSize: FontSize.bodyLargeRegular_size,
        fontFamily: FontFamily.bodyLargeSemibold,
        paddingTop: Padding.p_3xs,
    },
    productDescription: {
        fontSize: FontSize.bodyMediumRegular_size,
        paddingBottom: Padding.p_8xs,
        fontFamily: FontFamily.bodyMediumRegular,
    },
    settingsButton: {
        marginRight: Padding.p_base,
        width: 24,
        height: 24,        
    },
});

export default Index;

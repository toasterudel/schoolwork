//File   : GUI-lowlevel/cards1/cards/Card.java
//Purpose: Represents one card.
//Author : Fred Swartz - February 19, 2007 - Placed in public domain.
//
//Enhancements:
//       * Needs to have Suit and Face value.

/*
 * Card.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * 
 */
package Lab10;


import java.awt.*;
import javax.swing.*;

/////////////////////////////////////////////////////////////////////////// Card
class Card {
 //=================================================================== fields
 private ImageIcon _image, tempImage;
 private int       _x;
 private int       _y;
 private boolean faceUp; //This is true if the card is face up
 public static final String NAME = "CHRISTOPHER_RUDEL";
 
 //============================================================== constructor
 public Card(ImageIcon image) {
     _image = image;
     this.faceUp = true;
 }
 
 //=================================================================== moveTo
 public void moveTo(int x, int y) {
     _x = x;
     _y = y;
 }
 
 //================================================================= contains
 public boolean contains(int x, int y) {
     return (x > _x && x < (_x + getWidth()) && 
             y > _y && y < (_y + getHeight()));
 }
 
 //================================================================= getWidth
 public int getWidth() {
     return _image.getIconWidth();
 }
 
 //================================================================ getHeight
 public int getHeight() {
     return _image.getIconHeight();
 }
 
 //===================================================================== getX
 public int getX() {
     return _x;
 }
 
 //===================================================================== getY
 public int getY() {
     return _y;
 }
 
 //===================================================================== draw
 public void draw(Graphics g, Component c) {
     _image.paintIcon(c, g, _x, _y);
 }
 
 public void flip() //flips the card
 {
	 if(this.faceUp)
	 {
		 this.tempImage = _image;
		 this._image = new ImageIcon("./src/Lab10/images/b.gif");
		 this.faceUp = false;
		 
	 }
	 else
	 {
		 this._image = this.tempImage;
		 this.faceUp = true;
	 }
	 
 }
 
 
 
}

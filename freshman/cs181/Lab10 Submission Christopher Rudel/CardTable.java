//File   : GUI-lowlevel/cards1/cards/CardTable.java
//Purpose: This is just a JComponent for drawing the cards that are
//       showing on the table.
//
//Author : Fred Swartz - February 19, 2007 - Placed in public domain.
//
//Enhancements:
//     * Use model. Currently, it is initialized with a whole deck of cards,
//       but instead it should be intialized with a "model" which
//       it should interrogate (calling model methods) to find out what
//       should be displayed.
//     * Similarly, actions by the mouse might be used to set things in the
//       model, Perhaps by where it's dragged to, or double-clicked, or
//       with pop-up menu, or ...


/*
 * CardTable.java
 * I pledge my honor that I have abided by the Stevens Honor System
 * Christopher Rudel
 * 
 */


package Lab10;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

//////////////////////////////////////////////////////////////////////CardTable
public class CardTable extends JComponent implements MouseListener,
     MouseMotionListener {
 
 //================================================================ constants
 private static final Color BACKGROUND_COLOR = Color.GREEN;
 private static final int   TABLE_WIDTH       = 800;    // Pixels.
 private static final int   TABLE_HEIGHT      = 400;    // Pixels.
 public static final String NAME = "CHRISTOPHER_RUDEL";
 
 //=================================================================== fields
 //... Initial image coords.
 private int _initX     = 0;   // x coord - set from drag
 private int _initY     = 0;   // y coord - set from drag
 
 //... Position in image of mouse press to make dragging look better.
 private int _dragFromX = 0;  // Displacement inside image of mouse press.
 private int _dragFromY = 0;
 
 private Card[] _deck;        // Should really be in a model, but ...

 private Card   _currentCard = null;  // Current selected card.
 
 //============================================================== constructor
 public CardTable(Card[] deck) {
     _deck = deck;                // Should be passed a model.
     
     //... Initialize graphics
     setPreferredSize(new Dimension(TABLE_WIDTH, TABLE_HEIGHT));
     setBackground(Color.blue);
     
     //... Add mouse listeners.
     addMouseListener(this);
     addMouseMotionListener(this);
 }
 
 //=========================================================== paintComponent
 @Override
 public void paintComponent(Graphics g) {
     //... Paint background
     int width = getWidth();
     int height = getHeight();
     g.setColor(BACKGROUND_COLOR);
     g.fillRect(0, 0, width, height);
     
     //... Display the cards, starting with the first array element.
     //    The array order defines the z-axis depth.
     for (Card c : _deck) {
         if (null != c)   c.draw(g, this);
     }
     
     JButton b1 = new JButton();
     b1.setText("Rest");
     b1.setBounds(0, 390, width, height);
     b1.isVisible();
     g.drawRect(0,390 , width, 10);
     
     
 }
 
 //====================================================== method mousePressed
 // Check to see if press is within any card.
 // If it is,
 // * Set _currentCard so mouseDragged knows what to drag.
 // * Record where in the image (relative to the upper left coordinates)
 //   the mouse was clicked, because it looks best if we drag from there.
 // TODO: Move the card to the last position so that it displays on top.
 public void mousePressed(MouseEvent e) {
     int x = e.getX();   // Save the x coord of the click
     int y = e.getY();   // Save the y coord of the click
     
     //... Find card image this is in.  Check from top down.
     _currentCard = null;  // Assume not in any image.
     for (int crd=_deck.length-1; crd>=0; crd--) {
         Card testCard = _deck[crd];
         if ((null != testCard) && (testCard.contains(x, y))) {
             //... Found, remember this card for dragging.
             _dragFromX = x - testCard.getX();  // how far from left
		_dragFromY = y - testCard.getY();  // how far from top
		_currentCard = testCard;  // Remember what we're dragging.
		
		
		
		//This puts card selected at the front of the pack
		for(int i=crd; i<_deck.length -1; i++)
		{
			_deck[i] = _deck[i+1];
			this.repaint();
		}
		_deck[51] = testCard;
		
		_currentCard = testCard;
		
             break;        // Stop when we find the first match.
         }
         
         
     }
 }
 
 //============================================================= mouseDragged
 // Set x,y to mouse position and repaint.
 public void mouseDragged(MouseEvent e) {
     if (_currentCard != null) {   // Non-null if pressed inside card image.
    	 
         
         int newX = e.getX() - _dragFromX;
         int newY = e.getY() - _dragFromY;
         
         //--- Don't move the image off the screen sides
         newX = Math.max(newX, 0);
         newX = Math.min(newX, getWidth() - _currentCard.getWidth());
         
         //--- Don't move the image off top or bottom
         newY = Math.max(newY, 0);
         newY = Math.min(newY, getHeight() - _currentCard.getHeight());
         
         _currentCard.moveTo(newX, newY);
         
         this.repaint(); // Repaint because position changed.
     }
 }
 
 //======================================================= method mouseExited
 // Turn off dragging if mouse exits panel.
 public void mouseExited(MouseEvent e) {
	_currentCard = null;
 }

 public void mouseReleased(MouseEvent e) {
	_currentCard = null;
 }
 
 //=============================================== Ignore other mouse events.
 public void mouseMoved   (MouseEvent e) {}  // ignore these events
 public void mouseEntered(MouseEvent e) {} // ignore these events
 
 public void mouseClicked(MouseEvent e)
 {
	 //this flips the card if it is double clicked
	 if(e.getClickCount() ==2)
	 {
		 int x = e.getX(); // Save the x coord
		 int y = e.getY(); // Save the y coord
		 
		 _currentCard = null; //Assume not in any image
		 
		 for(int card=_deck.length-1; card>=0; card--)
		 {
			 Card testCard = _deck[card];
			 if((null != testCard) && (testCard.contains(x, y)))
			 {
				 _currentCard = testCard;
				 _currentCard.flip();
				 this.repaint();
				 break; 	//Stop when we find the first match
			 }
		 }
		 
	 }
 }  // ignore these events



}

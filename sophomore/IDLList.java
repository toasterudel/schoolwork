package homework;

import java.util.ArrayList;

import lecture.QueueLL;

public class IDLList<E> {
	//private node class
	private static class Node<E>{
		//data fields
		private E data;
		private Node<E> next = null;
		private Node<E> prev = null;
		//constructors
		private Node(E dataItem) {
			data = dataItem;
		}
		private Node(E dataItem, Node<E> p, Node<E> n) {
			data = dataItem;
			prev = p;
			next = n;
		}
	}
	//data fields
	private Node<E> head;
	private Node<E> tail;
	private int size;
	private ArrayList<Node<E>> indices;
	//constructor
	public IDLList() {
		head=null;
		tail=null;
		size=0;
		indices=null;
	}
	//methods
	//adds an element at index number
	public boolean add(int index, E elem) {
		return true;
	}
	//adds first element
	public boolean add(E elem) {
		if(head==null) {
			head.data = elem;
			size++;
			indices.add(head);
			return true;
		}
		return false;
	}
	//appends to end of list(at the tail)
	public boolean append(E elem) {
		return true;
	}
	//returns value at index
	public E get(int index) {
		return head.data;
	}
	
	public static void main(String[] args) {
		IDLList list = new IDLList();
		list.add(3);
		System.out.println(list);
		
	}
}

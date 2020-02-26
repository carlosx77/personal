package cracking.stringsandarrays.zeromatrix;

import java.util.HashMap;

public class ZeroMatrix {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ZeroMatrix zeroMatrix = new ZeroMatrix();
		byte[][] matrix = new byte [][] {
			{0, 1, 1, 1},
			{1, 1, 0, 1},
			{1, 1, 1, 1},
			{1, 1, 1, 0}
		};
		
		byte[][] zerosMatrix =  zeroMatrix.zeroMatrix(matrix);
		
		for (int x = 0; x<matrix.length; x++ ) {
			for (int y=0; y<matrix.length; y++ ) {
				System.out.print(matrix[x][y] + ", ");
			}
			System.out.println("");
		} //CHANGE THE SETTING, in the for ask if the column is set or not
	}
	
	//podemos evitar el uso de variables temporales xZeros and yZeros by movin the zeros to the first
	//x and y positions

	private byte[][] zeroMatrix(byte[][] matrix) {
		//HashMap<Integer, Integer> xZeros = new HashMap<> ();
		//HashMap<Integer, Integer> yZeros = new HashMap<> ();\
		boolean[] xZeros = new boolean[matrix.length];
		boolean[] yZeros = new boolean[matrix[0].length];
		for (int x = 0; x<matrix.length; x++ ) {
			for (int y=0; y<matrix.length; y++ ) {
				if ( matrix[x][y] == 0 ) {
					xZeros[x] = true;
					yZeros[y] = true;
 				}
			}
		}
		
		//There is no need to iterate all!!!!
		for (int x = 0; x<matrix.length; x++ ) {
			for (int y=0; y<matrix.length; y++ ) {
				if ( xZeros[x] == true || yZeros[y] == true ) {
					matrix[x][y] = 0;
 				}
			}
		}
		
		return matrix;
	}

}

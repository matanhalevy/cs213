package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

public class MainMemoryTest {
    MainMemory main;
    @Before
    public void setUp() throws Exception {
        byte[] mem;

        main = new MainMemory(100);
    }

    @Test
    public void testIsAccessAlignedAligned1(){
       Assert.assertTrue(main.isAccessAligned(4, 4));
    }

    @Test
    public void testIsAccessAlignedAligned2(){
        Assert.assertTrue(main.isAccessAligned(32,16));
    }

    @Test
    public void testIsAccessAlignedNotAligned(){
        Assert.assertFalse(main.isAccessAligned(7, 16));
    }

    @Test
    public void testBytesToInteger(){
        byte mem1[] = new byte[4];
        mem1[3] = 01;
        mem1[2] = 02;
        mem1[1] = 03;
        mem1[0] = 04;
        byte mem2[] = new byte[4];
        mem2[3] = 0;
        mem2[2] = 0;
        mem2[1] = 0;
        mem2[0] = 0;
        assertEquals((main.bytesToInteger(mem1[0], mem1[1], mem1[2], mem1[3])), 67305985);
        assertEquals((main.bytesToInteger(mem2[0], mem2[1], mem2[2], mem2[3])), 0);
    }

    @Test
    public void testIntegerPositiveToBytes(){
        byte [] mem1 = new byte[]{(byte) 0x00, (byte) 0xbc, (byte) 0x61, (byte) 0x4e};
        byte [] test1 = main.integerToBytes(12345678);
        for (int i = 0; i < mem1.length; i++) {
            assertEquals(test1[i], mem1[i]);
        }
    }

    @Test
    public void testNegativeIntegerToBytes(){
        byte [] mem1 = new byte[]{(byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xd1};
        byte [] test1 = main.integerToBytes(-47);
        for (int i = 0; i < mem1.length; i++) {
            assertEquals(test1[i], mem1[i]);
        }
    }

    @Test
    public void testSetAndGetWorking() throws Exception {
        byte mem1[] = new byte[4];
        mem1[3] = 1;
        mem1[2] = 2;
        mem1[1] = 3;
        mem1[0] = 4;
        main.set(0, mem1);

           assertArrayEquals(main.get(0, mem1.length),mem1);
        }

    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testSetThrowsInvalidArgument() throws AbstractMainMemory.InvalidAddressException {
        byte mem1[] = new byte[4];
        mem1[3] = 1;
        mem1[2] = 2;
        mem1[1] = 3;
        mem1[0] = 4;
        main.set(-1, mem1);
    }

    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testSetOutOfBoundsThrowsInvalidArgument() throws AbstractMainMemory.InvalidAddressException {
        byte mem1[] = new byte[4];
        mem1[3] = 1;
        mem1[2] = 2;
        mem1[1] = 3;
        mem1[0] = 4;
        main.set(99, mem1);
    }
    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testGetThrowsInvalidArgument() throws AbstractMainMemory.InvalidAddressException {
        main.get(-1, 12);
    }

    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testGetOutOfBoundsThrowsInvalidArgument() throws AbstractMainMemory.InvalidAddressException {
        main.get(90, 12);
    }
}
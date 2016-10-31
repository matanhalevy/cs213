package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertArrayEquals;
public class MainMemoryTest {
    MainMemory main;
    @Before
    public void setUp() throws Exception {
        byte[] mem;
        main = new MainMemory(100);
    }

    @Test
    public void testIsAccessAlignedNotAligned(){
        byte[] mem1 = new byte[4];
        mem1[3] = 1;
        mem1[2] = 2;
        mem1[1] = 3;
        mem1[0] = 4;
        byte[] mem2 = new byte[4];
        mem2[7] = 1;
        mem2[6] = 2;
        mem2[5] = 3;
        mem1[4] = 4;
        main.isAccessAligned();
    }

    @Test
    public void testIsAccessAligned() throws Exception {
    }
    @Test
    public void testBytesToInteger() throws Exception {
    }
    @Test
    public void testIntegerToBytes() throws Exception {
    }
    @Test
    public void testGet() throws Exception {
    }
    @Test
    public void testSet() throws Exception {
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
    public void testGetThrowsInvalidArgument() throws AbstractMainMemory.InvalidAddressException {
        main.get(-1, 12);
    }
}
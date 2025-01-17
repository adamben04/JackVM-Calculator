public class Debug {
    public static boolean debugMessages   = true;
    public static final int DEBUGLEVELMIN = 1;
    public static final int DEBUGLEVELMAX = 10;

    public static void println(int level, String label, byte[] packet) {
        if ((level >= DEBUGLEVELMIN) && (level <= DEBUGLEVELMAX)) {
            for (int i = 0; i < packet.length; i++)
                label += " " + Integer.toString((packet[i] & 0xff) + 0x100, 16).substring(1);
            System.err.println(label);
        }
    }

    public static void println(int level, String debugMessage) {
        if ((level >= DEBUGLEVELMIN) && (level <= DEBUGLEVELMAX)) { System.err.println(debugMessage); }
    }

    public static String printByteArray(byte[] packetData) {
        String output = "";
        for (int i = 0; i < packetData.length; i++)
            output += " " + Integer.toString((packetData[i] & 0xff) + 0x100, 16).substring(1);
        return output;
    }
}
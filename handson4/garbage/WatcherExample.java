package rsp.zookeeper;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;

import static java.lang.Thread.sleep;

public class WatcherDemo {

    private static String host = "172.20.0.13:2181";
    private static String parent = "/";
    private static String path = "";
    private static String socket = "";
    private static Map<String, String> host_file = new HashMap<String, String>();
    private static List<String> peers = new LinkedList<String>();

    private static ZooKeeper zk;

    public static void init() {
        try {
            zk = new ZooKeeper(host, 6000, new Watcher() {
                public void process(WatchedEvent watchedEvent) {
                System.out.println("Receive event " + watchedEvent);
                if (Event.KeeperState.SyncConnected == watchedEvent.getState())
                {
                    System.out.println("connection is ok");
                }
                }
            });
        } catch (IOException e) {
            System.out.println("connection failed.");
            e.printStackTrace();
        }
    }

    public static void watch() throws Exception {
        zk.create(path, socket.getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        zk.exists(path, new Watcher() {
            public void process(WatchedEvent watchedEvent) {
            try {
                System.out.println("监听的节点有变化，触发事件");
                System.out.println(watchedEvent.getPath());
                System.out.println(watchedEvent.getState());
                System.out.println(watchedEvent.getType());
            } catch (Exception e) {
                e.printStackTrace();
            }
            }
        });
        // 通过删除/zx3节点来触发watcher事件
        zk.delete(path, -1);
    }

    public static void getHostFile() throws Exception {
        peers = zk.getChildren(parent, true);
        for (String peer : peers) {
            try {
                String data = new String(zk.getData(peer, true, null));
                host_file.put(peer, data);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void zookeeperTest() throws Exception {
        System.out.println("=========创建节点===========");
        if (zk.exists("/test", false) == null) {
            zk.create("/test", "znode1".getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        }
        System.out.println("=============查看节点是否安装成功===============");
        System.out.println(new String(zk.getData("/test", false, null)));

        System.out.println("=========修改节点的数据==========");
        zk.setData("/test", "zNode2".getBytes(), -1);
        System.out.println("========查看修改的节点是否成功=========");
        System.out.println(new String(zk.getData("/test", false, null)));

        System.out.println("=======删除节点==========");
        zk.delete("/test", -1);
        System.out.println("==========查看节点是否被删除============");
        System.out.println("节点状态：" + zk.exists("/test", false));
    }

    public static void main(String args[]) throws Exception {
        path = args[0];
        socket = args[1];
        System.out.println(path);
//        init();
        try {
            zk = new ZooKeeper(host, 6000, new Watcher() {
                public void process(WatchedEvent watchedEvent) {
                    System.out.println("Receive event " + watchedEvent);
                    if (Event.KeeperState.SyncConnected == watchedEvent.getState())
                    {
                        System.out.println("connection is ok");
                    }
                }
            });
        } catch (IOException e) {
            System.out.println("connection failed.");
            e.printStackTrace();
        }

        System.out.println("zookeeper connection finished");
        zookeeperTest();
        System.out.println("zookeeper test finished");
        getHostFile();
        System.out.println("while start.");
        int i = 0;
        while (i < 30) {
            watch();
            i++;
            sleep(1000);
        }
    }
}

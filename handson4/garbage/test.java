package zkWatcher;

import java.io.IOException;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;

public class WatcherExample implements Watcher {
	private String host="localhost:2181";
	
	public void process(WatchedEvent event) {
		if(Event.KeeperState.SyncConnected != event.getState()){
            System.out.println("connection fail.");
        }
	
	}
	
	public String getZkpath() {
		return host;
	}

	public void setZkpath(String zkpath) {
		this.host = zkpath;
	}

	public static void main(String[] args){
		WatcherExample  wx = new WatcherExample();
		try {
            ZooKeeper	zk = new ZooKeeper(wx.getZkpath(),10000, wx);
            if (zk.exists("/test", false)==null) {
                zk.create("/test", "znode1".getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
            }
            System.out.println(new String(zk.getData("/test", false, null)));
            zk.setData("/test", "znode2".getBytes(), -1);
            System.out.println(new String(zk.getData("/test", false, null)));
			// Thread.sleep(300000);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (KeeperException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}

}
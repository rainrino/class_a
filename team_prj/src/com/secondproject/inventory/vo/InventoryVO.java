package com.secondproject.inventory.vo;

public class InventoryVO {

	private int optiStock, curStock;
	private String prjName,empName,itemName,orderDate,inStockDate,unit,status;
	public InventoryVO() {
		super();
	}
	public InventoryVO( String prjName, String empName, String itemName,
			String orderDate, String inStockDate, String unit, int optiStock, int curStock, String status) {
		this.optiStock = optiStock;
		this.curStock = curStock;
		this.prjName = prjName;
		this.empName = empName;
		this.itemName = itemName;
		this.orderDate = orderDate;
		this.inStockDate = inStockDate;
		this.unit = unit;
		this.status = status;
	}
	public int getOptiStock() {
		return optiStock;
	}
	public void setOptiStock(int optiStock) {
		this.optiStock = optiStock;
	}
	public int getCurStock() {
		return curStock;
	}
	public void setCurStock(int curStock) {
		this.curStock = curStock;
	}
	public String getPrjName() {
		return prjName;
	}
	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getInStockDate() {
		return inStockDate;
	}
	public void setInStockDate(String inStockDate) {
		this.inStockDate = inStockDate;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}

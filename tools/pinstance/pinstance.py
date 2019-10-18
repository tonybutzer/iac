import click
import util
import json

chs=True
myip = "PrivateIpAddress"
#myip = "PublicIpAddress"

#print ("HELLO")


@click.group()
def cli():
   """ This script will work on instances """
   pass
@cli.command()
def status():
   """ prints and running instances """
   #print("STATUS")
   jsonData = util.ec2status()
   jsonBlob = json.loads(jsonData)
   mynew = jsonBlob.get("Reservations")

   for myDict in mynew:
      print ('-'*60)
      ids = myDict["Instances"]
      for id in ids:
         tagName = util.get_tag_name(id)
         iState = id["State"]
         #print (iState["Name"])
         print ("The INSTANCE %s is %s " % (tagName, iState["Name"]))
         iState = id["State"]
         #print (iState["Name"])
         realState = iState["Name"]
         if (realState == "running"):
            if myip in id.keys():
                print (id[myip])


   
@cli.command()
@click.option('--tag', default='bulkHelper', help="This is the name of the EC2 Instance (tag)", required=True)
def start(tag):
   """ starts an instance """
   jsonData = util.ec2status()
   jsonBlob = json.loads(jsonData)
   mynew = jsonBlob.get("Reservations")

   for myDict in mynew:
      ids = myDict["Instances"]
      for id in ids:
         tagName = util.get_tag_name(id)

         instanceId = id["InstanceId"]
         iState = id["State"]
         if (tagName == tag):
            print ("The INSTANCE %s is %s " % (tagName, iState["Name"]))
            print ("Starting instance ID %s " % instanceId)
            print("START YOUR Engines %s" % tag)
            util.ec2start(id=instanceId)


@cli.command()
@click.option('--tag', default='bulkHelper', help="This is the name of the EC2 Instance (tag)", required=True)
def stop(tag):
   """ stops an instance """
   jsonData = util.ec2status()
   jsonBlob = json.loads(jsonData)
   mynew = jsonBlob.get("Reservations")

   for myDict in mynew:
      ids = myDict["Instances"]
      for id in ids:
         #print (id["InstanceType"])
         #print (id["InstanceId"])
         instanceId = id["InstanceId"]
         tagName = util.get_tag_name(id)

         instanceId = id["InstanceId"]
         iState = id["State"]
         if (tagName == tag):
            print ("Stopping instance ID %s " % instanceId)
            print ("The INSTANCE %s is %s " % (tagName, iState["Name"]))
            print ("KILL YOUR Engines %s" % tag)
            util.ec2stop(id=instanceId)

@cli.command()
@click.option('--tag', default='bulkHelper', help="This is the name of the EC2 Instance (tag)", required=True)
def getip(tag):
   """ gets the public ip of an instance """
   jsonData = util.ec2status()
   #print (json.dumps(jsonData, indent=2))
   jsonBlob = json.loads(jsonData)
   mynew = jsonBlob.get("Reservations")

   for myDict in mynew:
      ids = myDict["Instances"]
      for id in ids:
         #print (id["InstanceType"])
         #print (id["InstanceId"])
         iState = id["State"]
         #print (iState["Name"])
         #print ("The INSTANCE is %s " % iState["Name"])
         tagName = util.get_tag_name(id)

         if (tagName == tag):
            realState = iState["Name"]
            if (realState == "running"):
               print (id[myip])
            else:
               print ("ERROR the instance MUST be running to get its IP Address")

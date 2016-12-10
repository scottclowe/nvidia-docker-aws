# nvidia-docker on AWS

Nvidia has recently made it a lot easier to use Docker images in order to run Deep Learning and other GPU-based tasks.
I'm mostly a hobbiest (though I do use GPUs professionally sometimes) and so I can't really justify buying a [Dream Machine](http://graphific.github.io/posts/building-a-deep-learning-dream-machine/) when you can get spot instances of (decent) GPUs on AWS for $0.10-0.20/hr.

However, as with all things, setting up AWS instances is a PITA. This nice guy
[Sean](http://seanbe.github.io/post/deep-learning-aws/) wrote a lovely tutorial
on how to get everything going, but it is (a) out-of-date now that Ubuntu 16.04
Xenial is out, and its drivers are a bit behind. Moreover, it's a good
explainer, but I just want a list of commands to execute on the box! Hence, this repository!

## Requirements

Launch an AWS box with some GPUs in it. I've been using `g2.2xlarge`s. Make
sure to request Spot Instances if you're cool with that.

Once you've gotten all that setup, just download `nvidia.sh` and run
```
sudo ./nvidia.sh
```

## Questions

I haven't been able to turn this into an AMI. The machine boots and either the
nvidia-docker plugin is screwed up, OR the nvidia kernel module doesn't load.
If anyone has suggestions, let me know how to turn this into a functioning AMI.

## Acknowledgements

This is all just a scripted and updated version of [this awesome tutorial](http://seanbe.github.io/post/deep-learning-aws/).

## Licence

CC-BY-SA 4.0
